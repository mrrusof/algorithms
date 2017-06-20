import java.util.Scanner;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while (in.hasNextInt()) {
            int m = in.nextInt();
            int n = in.nextInt();
            int[][] M = readMatrix(m, n, in);
            setZeroes(M);
            printMatrix(M, m, n);
        }
    }

    static int[][] readMatrix(int m, int n, Scanner in) {
        int[][] M = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                M[i][j] = in.nextInt();
            }
        }
        return M;
    }

    static void printMatrix(int[][] M, int m, int n) {
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                System.out.print(M[i][j] + " ");
            }
            System.out.println();
        }
    }

    static void setZeroes(int[][] M) {
        boolean first_row = false;
        boolean first_col = false;
        int m = M.length;
        int n = M[0].length;

        // mark cols and rows
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (M[i][j] == 0) {

                    //mark col
                    if (j == 0) {
                        first_col = true;
                    } else {
                        M[0][j] = 0;
                    }

                    //mark row
                    if (i == 0) {
                        first_row = true;
                    } else {
                        M[i][0] = 0;
                    }
                }
            }
        }

        // set cols to zero
        for (int j = 1; j < n; j++) {
            if (M[0][j] == 0) {
                for (int i = 0; i < m; i++) {
                    M[i][j] = 0;
                }
            }
        }
        
        // set rows to zero
        for (int i = 1; i < m; i++) {
            if (M[i][0] == 0) {
                for (int j = 0; j < n; j++) {
                    M[i][j] = 0;
                }
            }
        }
        
        // set first col to zero
        if (first_col) {
            for (int i = 0; i < m; i++) {
                M[i][0] = 0;
            }
        }

        //set first row to zero
        if (first_row) {
            for (int j = 0; j < n; j++) {
                M[0][j] = 0;
            }
        }
    }

}
