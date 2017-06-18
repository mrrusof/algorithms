import java.util.Scanner;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(true) {
            if (! in.hasNextLine()) break;
            StringBuilder s = new StringBuilder(in.nextLine());
            if (! in.hasNextInt()) break;
            int length = in.nextInt();
            escapeSpaces(s, length + 1);
            System.out.println(s);
        }
    }

    public static void escapeSpaces(StringBuilder s, int length) {
        int spaces = 0;
        int lastPos;

        //count spaces
        for (int i = 0; i < length; i++) {
            if (s.charAt(i) == ' ') {
                spaces++;
            }
        }

        lastPos = length + spaces * 2;

        //move last chars to last pos, starting from right
        while (0 < length-- && spaces > 0) {
            if (s.charAt(length) == ' ') {
                s.setCharAt(--lastPos, '0');
                s.setCharAt(--lastPos, '2');
                s.setCharAt(--lastPos, '%');
                spaces--;
            } else {
                s.setCharAt(--lastPos, s.charAt(length));
            }
        }
    }

}
