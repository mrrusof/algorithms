import java.util.Scanner;
import java.util.Map;
import java.util.Hashtable;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        while(in.hasNextLine()) {
            String s = in.nextLine();
            System.out.println(isPermutationOfPalindrome(s.replaceAll("\\s+", "")));
        }
    }

    public static boolean isPermutationOfPalindrome(String s) {
        Map<Character, Integer> counts = new Hashtable<>();
        int length = s.length();

        //count letters
        for (int i = 0; i < length; i++) {
            Character curr = s.charAt(i);
            if (! counts.containsKey(curr))
                counts.put(curr, 0);
            counts.put(curr, counts.get(curr) + 1);
        }

        boolean someOdd = false;

        for (Map.Entry e : counts.entrySet()) {
            if ((Integer)e.getValue() % 2 != 0) { //odd
                if (someOdd)
                    return false;
                someOdd = true;
            }
        }

        if (length % 2 != 0 && !someOdd)
            return false;

        return true;
    }

}
