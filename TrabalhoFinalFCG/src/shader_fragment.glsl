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
#define MAINBUILD 3
#define BAGUETE 4
uniform int object_id;

// Parâmetros da axis-aligned bounding box (AABB) do modelo
uniform vec4 bbox_min;
uniform vec4 bbox_max;

// Variáveis para acesso das imagens de textura
uniform sampler2D TextureImage0;
uniform sampler2D TextureImage1;
uniform sampler2D TextureImage2;
uniform sampler2D TextureImage3;

// cor branca para objetos destacados
uniform vec4 color_override;  // Cor para sobrescrever a cor padrão
uniform bool use_color_override; // Flag para indicar se devemos usar a cor de sobreposição

// O valor de saída ("out") de um Fragment Shader é a cor final do fragmento.
out vec4 color;

// Constantes
#define M_PI   3.14159265358979323846
#define M_PI_2 1.57079632679489661923

void main()
{
    // Obtemos a posição da câmera utilizando a inversa da matriz que define o
    // sistema de coordenadas da câmera.
    vec4 origin = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 camera_position = inverse(view) * origin;

    // O fragmento atual é coberto por um ponto que percente à superfície de um
    // dos objetos virtuais da cena. Este ponto, p, possui uma posição no
    // sistema de coordenadas global (World coordinates). Esta posição é obtida
    // através da interpolação, feita pelo rasterizador, da posição de cada
    // vértice.
    vec4 p = position_world;

    // Normal do fragmento atual, interpolada pelo rasterizador a partir das
    // normais de cada vértice.
    vec4 n = normalize(normal);

    // Vetor que define o sentido da fonte de luz em relação ao ponto atual.
    vec4 l = normalize(vec4(1.0,1.0,0.0,0.0));

    // Vetor que define o sentido da câmera em relação ao ponto atual.
    vec4 v = normalize(camera_position - p);

    // Coordenadas de textura U e V
    float U = 0.0;
    float V = 0.0;

    if ( object_id == SPHERE )
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
    else if ( object_id == BUNNY )
    {
        float minx = bbox_min.x;
        float maxx = bbox_max.x;

        float miny = bbox_min.y;
        float maxy = bbox_max.y;

        float minz = bbox_min.z;
        float maxz = bbox_max.z;

        U = (position_model.x - minx) / (maxx - minx);
        V = (position_model.y - miny) / (maxy - miny);
    }
    else if ( object_id == PLANE )
    {
        U = texcoords.x;
        V = texcoords.y;
    }
    else if ( object_id == BAGUETE )
    {
        U = texcoords.x;
        V = texcoords.y;
    }

    // Equação de Iluminação
    float lambert = max(0,dot(n,l));
    float ambient_light = 0.4;

    // Calculamos cores diferentes dependendo do objeto
    vec3 Kd_final;

    if ( object_id == BAGUETE )
    {
        // Baguete usa apenas TextureImage2
        Kd_final = texture(TextureImage2, vec2(U,V)).rgb;
    }
        else if ( object_id == PLANE )
    {
        Kd_final = texture(TextureImage3, vec2(U,V)).rgb;
    }
    else
    {
        // Outros objetos usam TextureImage0 e TextureImage1 com interpolação
        vec3 Kd0 = texture(TextureImage0, vec2(U,V)).rgb;
        vec3 Kd1 = texture(TextureImage1, vec2(U,V)).rgb;
        Kd_final = mix(Kd1, Kd0, lambert);
    }

    if (use_color_override)
    {
        color = color_override;
    }
    else
    {
        color.rgb = Kd_final * (lambert + ambient_light);
        color.a = 1;
    }

    // Cor final com correção gamma, considerando monitor sRGB.
    color.rgb = pow(color.rgb, vec3(1.0,1.0,1.0)/2.2);
}
