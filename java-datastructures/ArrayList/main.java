import java.util.ListIterator;

public class main {
    public static void main(String[] args) {
        MyArrayList<Integer> l = new MyArrayList<>(0);
        assert(l.isEmpty());
        assert(l.add(3));
        assert(l.size() == 1);
        assert(! l.isEmpty());
        assert(l.get(0) == 3);
        assert(l.contains(3));
        assert(! l.contains(2));
        assert(l.add(2));
        assert(l.remove(0) == 3);
        assert(! l.contains(3));
        assert(l.contains(2));
        assert(l.remove(new Integer(2)));
        assert(l.size() == 0);
        l.add(10);
        l.add(0, 5);
        assert(l.get(0) == 5);
        assert(l.get(1) == 10);
        ListIterator<Integer> li = l.listIterator();
        while(li.hasNext())
            System.out.println(li.next());
    }
}
