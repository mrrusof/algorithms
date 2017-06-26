import java.util.Scanner;
import java.util.Map;
import java.util.HashMap;

public class main {

    public static void main(String... args) {
        Scanner in = new Scanner(System.in);
        Node h = new Node(null, 0);
        Node c = h;
        while(in.hasNextInt()) {
            int n = in.nextInt();
            c = c.next = new Node(null, n);
        }
        System.out.println(h.next.toString());
        h.next.dedup();
        System.out.println(h.next.toString());
    }
    
}

class Node {
    public Node next;
    public int value;

    public Node(Node next, int value) {
        this.next = next;
        this.value = value;
    }

    public String toString() {
        StringBuilder out = new StringBuilder();
        out.append(value);
        Node c = this;
        while (c.next != null) {
            c = c.next;
            out.append(" ");
            out.append(c.value);
        }
        return out.toString();
    }

    public void dedup() {
        Map<Integer, Integer> h = new HashMap<>();
        h.put(this.value, 1);
        Node c = this;
        while (c.next != null) {
            if (h.containsKey(c.next.value)) {
                c.next = c.next.next;
            } else {
                c = c.next;
                h.put(c.value, 1);
            }
        }
    }
}


