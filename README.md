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




