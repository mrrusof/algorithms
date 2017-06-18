import java.util.Scanner;
import java.util.Map;
import java.util.Hashtable;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(true) {
            if (! in.hasNextLine()) break;
            String a = in.nextLine();
            if (! in.hasNextLine()) break;
            String b = in.nextLine();
            if (isPermutation(a, b))
                System.out.println("true");
            else
                System.out.println("false");
        }
    }

    private static boolean isPermutation(String a, String b) {
        if (a.length() != b.length()) return false;
        Map<Character, Integer> h1 = countChars(a);
        Map<Character, Integer> h2 = countChars(b);
        for (Map.Entry e : h1.entrySet()) {
            if (h2.containsKey(e.getKey())) {
                if (h2.get(e.getKey()) != e.getValue()) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }

    private static Map<Character, Integer> countChars(String s) {
        Map<Character, Integer> h = new Hashtable<>();
        for (int i = 0; i < s.length(); i++) {
            Character c = s.charAt(i);
            if (h.containsKey(c)) {
                h.put(c, h.get(c) + 1);
            } else {
                h.put(c, 1);
            }
        }
        return h;
    }

}
