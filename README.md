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




