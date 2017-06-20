import java.util.Scanner;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while (in.hasNextInt()) {
            int n = in.nextInt();
            int A[][] = readMatrix(n, in);
            rotateMatrix(A);
            printMatrix(A);
        }
    }

    static int[][] readMatrix(int n, Scanner in) {
        int[][] A = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                A[i][j] = in.nextInt();
            }
        }
        return A;
    }

    static void printMatrix(int[][] A) {
        for (int i = 0; i < A.length; i++) {
            for (int j = 0; j < A.length; j++) {
                System.out.print(A[i][j] + " ");
            }
            System.out.println();
        }
    }

    static void rotateMatrix(int[][] A) {
        int n = A.length;
        for (int b = 0; n - b * 2 > 1; b++) {
            for (int i = 0; i < n - b * 2 - 1; i++) {
                int t = A[b][b + i];
                A[b][b + i] = A[n - b - 1 - i][b];
                A[n - b - 1 - i][b] = A[n - b - 1][n - b - 1 - i];
                A[n - b - 1][n - b - 1 - i] = A[b +i][n - b - 1];
                A[b + i][n - b - 1] = t;
            }
        }
    }

}
