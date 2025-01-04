#version 330 core

// Atributos de fragmentos recebidos como entrada ("in") pelo Fragment Shader.
// Neste exemplo, este atributo foi gerado pelo rasterizador como a
// interpolação da posição global e a normal de cada vértice, definidas em
// "shader_vertex.glsl" e "main.cpp".
in vec4 position_world;
in vec4 normal;

// Posição do vértice atual no sistema de coordenadas local do modelo.
in vec4 position_model;

// Coordenadas de textura obtidas do arquivo OBJ (se existirem!)
in vec2 texcoords;

// Matrizes computadas no código C++ e enviadas para a GPU
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

// Identificador que define qual objeto está sendo desenhado no momento
#define SPHERE 0
#define BUNNY  1
#define PLANE  2
#define LUA    3 // Adicionamos um identificador para a Lua
uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;

// Textura exclusiva para a Lua
uniform sampler2D TexturaLua;

// Cor branca para objetos destacados
uniform vec4 color_override;  // Cor para sobrescrever a cor padrão
uniform bool use_color_override; // Flag para indicar se devemos usar a cor de sobreposição

// Posição da Lua como fonte de luz
vec4 lua_light_position = vec4(5.0, 8.0, -13.0, 1.0); // Posição fixa da luz da Lua

// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923

void main()
{
    // O fragmento atual é coberto por um ponto que pertence à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da luz da Lua em relação ao ponto atual.
    vec4 l_lua = normalize(lua_light_position - p);

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;

    if (object_id == SPHERE || object_id == LUA) // Lua é tratada como esfera
    {
        vec4 bbox_center = (bbox_min + bbox_max) / 2.0;

        // Vetor do centro da esfera até o ponto atual
        vec4 r = position_model - bbox_center;

        // Normaliza o vetor r
        vec4 r_norm = normalize(r);

        // Calcula theta (longitude) usando atan(z, x)
        float theta = atan(r_norm.z, r_norm.x);

        // Calcula phi (latitude) usando asin(y)
        float phi = asin(r_norm.y);

        // Mapeia theta e phi para coordenadas UV no intervalo [0,1]
        U = (theta + M_PI) / (2.0 * M_PI);
        V = (phi + M_PI_2) / M_PI;
    }
    else if (object_id == BUNNY)
    {
        float minx = bbox_min.x;
        float maxx = bbox_max.x;

        float miny = bbox_min.y;
        float maxy = bbox_max.y;

        U = (position_model.x - minx) / (maxx - minx);
        V = (position_model.y - miny) / (maxy - miny);
    }
    else if (object_id == PLANE)
    {
        U = texcoords.x;
        V = texcoords.y;
    }

    // Aplicamos texturas diferentes dependendo do objeto
    vec3 Kd_final;
    if (object_id == LUA)
    {
        Kd_final = texture(TexturaLua, vec2(U, V)).rgb;
    }
    else
    {
        vec3 Kd0 = texture(TextureImage0, vec2(U, V)).rgb;
        vec3 Kd1 = texture(TextureImage1, vec2(U, V)).rgb;
        Kd_final = mix(Kd1, Kd0, max(0, dot(n, l_lua)));
    }

    // Componente de iluminação
    float lambert_lua = max(0, dot(n, l_lua));

    // Intensidade da luz ambiente
    float ambient_light = 0.4; // Controle de intensidade da luz ambiente

    // Cor final combinando a luz da Lua e a luz ambiente
    vec3 final_color = Kd_final * (lambert_lua + ambient_light);

    if (use_color_override)
    {
        color = color_override;
    }
    else
    {
        color.rgb = final_color; // Seu código original de cor aqui


        // NOTE: Se você quiser fazer o rendering de objetos transparentes, é
        // necessário:
        // 1) Habilitar a operação de "blending" de OpenGL logo antes de realizar o
        //    desenho dos objetos transparentes, com os comandos abaixo no código C++:
        //      glEnable(GL_BLEND);
        //      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        // 2) Realizar o desenho de todos objetos transparentes *após* ter desenhado
        //    todos os objetos opacos; e
        // 3) Realizar o desenho de objetos transparentes ordenados de acordo com
        //    suas distâncias para a câmera (desenhando primeiro objetos
        //    transparentes que estão mais longe da câmera).

        // Alpha default = 1 = 100% opaco = 0% transparente
        color.a = 1.0;
    }

    // Correção gamma, considerando monitor sRGB.
    // Veja https://en.wikipedia.org/w/index.php?title=Gamma_correction&oldid=751281772#Windows.2C_Mac.2C_sRGB_and_TV.2Fvideo_standard_gammas
    color.rgb = pow(color.rgb, vec3(1.0 / 2.2));
}
