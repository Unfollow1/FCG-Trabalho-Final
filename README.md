# Fundamentos de Computacao Grafica Trabalho Final 

![logo](https://github.com/user-attachments/assets/65e3737b-dfbf-43db-a4e2-34c2f72e7751)

IDEIA INICIAL:

O jogo se chamará "Neighborhood", e simulará uma vizinhança onde o jogador poderá explorar livremente a pé ou de bicicleta. O objetivo principal é sair de casa, e realizar compras no mercado e/ou o posto de gasolina e retornar. 
Durante a jornada, o jogador possivelemte poderá interagir com NPCs em diálogos e abrir um HUD de celular para consultar o horário.
Também estamos avaliando a possibilidade de um limite de tempo para a conclusão dessas tarefas, embora ainda seja uma ideia em estudo.

# Mecânicas Base Implementadas

1) Sistema de Movimentação
   - Controles WASD para movimentação do jogador
   - Câmera em primeira pessoa com altura fixa
   - Mouse controla a rotação da câmera
   - Bicicleta tecla [B] para mudar a velocidade do personagem

3) Sistema de Interação
   - Crosshair no centro da tela
   - Highlight em amarelo dos objetos interativos quando apontados
   - Tecla 'E' para interagir com objetos
   - Objetos desaparecem após interação

4) Sistema de Lista de Compras
   - Sorteio aleatório de 4 entre vários itens possíveis
   - Exibição da lista no canto superior direito
   - Lista com formato de checkbox [ ] para itens não coletados

5) Sistema de Lista de Itens Expandido
   - Ampliação para 15 itens possíveis
   - Implementação de IDs únicos para cada item
   - Mapeamento de IDs para nomes dos itens
     
6) Sistema de Tempo
   - Implementação de contador regressivo (2 minutos)
   - Display do tempo abaixo da lista de compras
   - Sistema de game over quando o tempo acaba

  # Bug fix & adaptações

  1) Sistema de Câmera e Controle
     - Mudança de câmera first-person com controle de mouse, **sem cursor**
     - Tecla [F] para colocar em tela cheia
     - Bug da primeira vez mexendo no mouse a camera ir para um lugar aleatório, resolvido

# Contribuições
1) Gabriel Berta
   - Iluminação da cena
   - Elemento que usa cruva de bezier
   - Cameras e movimentação
2) Gleydson Campos
   - Modelagem e texturização da cena 
   - Colisões
   - Lógica não trivial do jogo
  
# Manual do jogo
W -> Mover para frente
A -> Mover para o lado esquerdo 
S -> Mover para trás
D -> Mover para o lado direito
B -> Correr mais rápido
F -> Colocar em tela cheia
E -> Interagir com objetos
 
    
![image](https://github.com/user-attachments/assets/c185a8be-0f83-48f6-8480-da1dbe2c6afd)

# Passos necessários para compilação e execução da aplicação
1) Clonar repositório
2) Abrir arquivo 'laboratório_5'
3) Dar build
4) Executar
5) Possíveis erros: arquivo de colisões não encontrado, assim como ocorreu na apresentação final, estamos enviando os arquivos no .zip

![image](https://github.com/user-attachments/assets/30997b25-a61c-4690-8ad3-ddb538b6c411)

![image](https://github.com/user-attachments/assets/238fce64-673e-4087-80cf-84c1fb765744)

![image](https://github.com/user-attachments/assets/e16fa37d-13ee-48fd-aa90-f6c171c33bb3)


# Uso de IAs
Fizemos uso do ChatGPT principalmente para a geração de exemplos, correção de erros e para gerar ideias.
Uma das aplicações foram os pontos de Bezier gerados para colocar a esfera ( representando um mosquito ) perto do poste.
Na correção de erros a IA pode ser extremamente util, principalmente em erros de compilação, onde ela consegue facilmente achar os erros,
contudo para erros de execução ela já não foi tão util. Por fim ela foi utilizada para nos dar ideias, tanto de onde aplicar um conceito
para que ele não ficasse desconexo do contexto geral do jogo. Assim como para gerar códigos repetitivos.
No geral ela foi bem util.

# Descrição do Processo de Desenvolvimento e Aplicação dos Conceitos de Computação Gráfica
1) Estrutura e Organização do Projeto
   O projeto foi desenvolvido na linguagem C++,  utilizando a biblioteca GLFW para a criação de janelas e gerenciamento de eventos. Além disso, foi utilizado o GLAD para o carregamento das funções OpenGL 3.3. Também foram utilizadas as bibliotecas GLM para operações com matrizes e vetores, tinyobjloader para carregar modelos    .obj, e stb_image para carregamento de texturas. Tendo em vista essas condições, os arquivos principais são:
   main.cpp: Contendo a função main() e todo o loop principal de renderização;
   collisions.hpp: Definindo as funções e estruturas auxiliares para detecção de colisões (Bounding Box, Bounding Sphere, etc.);
   utils.h e matrices.h: Contendo funções e matrizes para transformações (translações, rotações, escalas, projeções, etc.);
   Arquivos de shaders (shader_vertex.glsl e shader_fragment.glsl): Contendo o código GLSL para a pipeline de GPU.
   Desta forma, para o carregamento dos modelos em 3D e  para desenhar objetos na cena, foram utilizados os modelos .obj de formas diferentes, sendo elas: coelho, casa, rua etc. O objetivo dessas estruturas é demonstrar a modelagem e representação geométrica em Computação Gráfica, pois  foi construída uma malha de triângulos    para cada objeto 3D. Para isso foram utilizados os seguintes recursos: 
   Tinyobjloader: Construir o parsing dos arquivos .obj e carregar atributos de vértices, normais e coordenadas de textura;
   Estrutura ObjModel: Armazenar as informações brutas de cada modelo carregado (atributos vertices, normals, texcoords, etc.).
   Função BuildTrianglesAndAddToVirtualScene():
   Converter os dados brutos do ObjModel em buffers de vértice (VBOs) e de índice (EBO), criando também o VAO.
   Calcula as bounding boxes (AABB) para cada objeto, necessárias para as colisões e para passar dados de bounding box ao shader.
   Seguindo a estrutura da avaliação, para posicionar, rotacionar e escalar cada objeto em uma matriz, foram utilizadas as funções de transformações definidas em matrices.h, como as funções Matrix_Translate, Matrix_Rotate_X, Matrix_Rotate_Y, Matrix_Scale, entre outras.  Sendo assim, vale ressaltar que cada objeto possui a       sua matriz model configurada de forma que cada objeto translade para certa posição no espaço ou seja escalada, de formas diferentes, para ter o seu tamanho ajustado. Em outros casos, é utilizado a Stack de matrizes  (PushMatrix, PopMatrix) que utiliza alguns trechos para ajustar a  hierarquia das transformações de cada       objeto. 
   O projeto implementa duas “câmeras” principais para a visualização do objeto. Por isso, foi definida a Matriz View, a câmera.A posição final da câmera em coordenadas de mundo gera a matriz view através de Matrix_Camera_View. Desta forma, essas duas câmeras são: a Câmera Livre(First-person), que é controlada pelas  teclas     W, A, S, D (para deslocamento) e movimento do mouse (para ângulo de rotação).A segunda câmera (Look-At) tem o objetivo de girar em torno de um ponto de interesse quando o jogador fica inativo.  
   Em relação a matriz de projeção, cada perspectiva foi definida pela variáveis: Matrix_Perspective (field_of_view, aspect_ratio, nearplane, farplane). Além disso, há suporte para  projeção ortográfica (Matrix_Orthographic), mas por padrão utiliza-se a perspectiva (teclas ‘P’ e ‘O’ alternam entre elas). Com isso, essas         transformações demonstram o uso de sistemas de coordenadas (modelo, mundo, câmera, projeção) e transformações 3D.
   Com relação a iluminação e shaders, existe um vertex shader que recebe os atributos de posição, do normal e da textura de cada vértice. Aplicando, assim, as matrizes:  model, view e projection.Além disso, existe um fragment shader que recebe a cor interpolada e faz a aplicação de texturas, para cada objeto. Nesse sentido,    vale ressaltar que alguns objetos têm texturas específicas (asfalto, calçada, baguete, etc.) definidas via sampler2D. Cada textura é carregada via LoadTextureImage() e vinculada a uma textura unit. Com isso, esses códigos de shaders e de aplicação de texturas procura abordar conceitos de renderização e mapeamento de          texturas em Computação Gráfica.  
   Referente a colisão dos objetos, foram implementadas e utilizadas diferentes formas para detectar as colisões,sendo elas:Bounding Box (Axis-Aligned e Oriented); Bounding Sphere e  Ray Casting . As estruturas de Bounding Box são utilizadas para verificar se existem sobreposições entre a caixa do jogador e as caixas de         objetos (casa, máquina de pagamentos entre outros. Por sua vez, as estruturas de Bounding Sphere  são utilizadas para detectar colisões simples, como é o caso de colisão com o objeto que é o coelho. A função SphereToSphereCollision, por sua vez,  verifica a interseção entre esferas baseadas em um raio definido. Por          último, a função Ray Casting é utilizada para destacar objetos sob o  “crosshair”. Com essa função, é possível lançar um “raio”  a partir da câmera (direção de view) para verificar se atinge algum bounding box do objeto.




