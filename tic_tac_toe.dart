import 'dart:io';

void main() {
  print("Welcome to Tic-Tac-Toe!");

  // Main game loop
  while (true) {
    playGame();  // Call the function to start the game

    // Ask the player if they want to play again
    print("Do you want to play again? (yes/no)");
    String playAgain = stdin.readLineSync()?.toLowerCase() ?? "";

    if (playAgain != "yes") {
      print("Thanks for playing. Goodbye!");
      break;
    }
  }
}

void playGame() {
  List<String> board = List.filled(9, ' ');  // Initialize an empty 3x3 board
  List<List<int>> winConditions = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],  // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8],  // Columns
    [0, 4, 8], [2, 4, 6],  // Diagonals
  ];

  String playerX = 'X';
  String playerO = 'O';
  String currentPlayer = playerX;

  // Game loop for each turn
  while (true) {
    printBoard(board);  // Display the current state of the board

    // Prompt the current player for their move
    print("Player $currentPlayer's turn. Enter your move (1-9): ");
    int? move = getValidMove(board);

    board[move! - 1] = currentPlayer;  // Place the player's marker on the board

    // Check for a win
    if (checkWin(board, winConditions, currentPlayer)) {
      printBoard(board);
      print("Player $currentPlayer wins!");
      break;
    }

    // Check for a draw
    if (board.every((cell) => cell != ' ')) {
      printBoard(board);
      print("It's a draw!");
      break;
    }

    currentPlayer = (currentPlayer == playerX) ? playerO : playerX;  // Switch players for the next turn
  }

  print("Game over!");
}

void printBoard(List<String> board) {
  // Display the current state of the board
  print(" ${board[0]} | ${board[1]} | ${board[2]} ");
  print("-----------");
  print(" ${board[3]} | ${board[4]} | ${board[5]} ");
  print("-----------");
  print(" ${board[6]} | ${board[7]} | ${board[8]} ");
}

int? getValidMove(List<String> board) {
  while (true) {
    // Prompt the player for their move and validate input
    String? input = stdin.readLineSync();
    int? move = int.tryParse(input ?? '');
    if (move != null && move >= 1 && move <= 9 && board[move - 1] == ' ') {
      return move;
    } else {
      print("Invalid move. Please enter a valid move (1-9): ");
    }
  }
}

bool checkWin(List<String> board, List<List<int>> winConditions, String player) {
  // Check for a win based on the win conditions
  for (var condition in winConditions) {
    if (board[condition[0]] == player &&
        board[condition[1]] == player &&
        board[condition[2]] == player) {
      return true;
    }
  }
  return false;
}
