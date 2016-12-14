import java.util.List;

public class MyArrayList<E> {

    private Object[] data;
    private int length;

    public MyArrayList(int capacity) {
        if(capacity < 0)
            throw new IllegalArgumentException("Illegal capacity: " + capacity);
        data = new Object[capacity];
    }

    public MyArrayList() {
        this(10);
    }

    // optional
    public boolean add(E e) {
        if(length >= data.length) {
            Object[] t = new Object[data.length + 1 * 2];
            for(int i = 0; i < data.length; i++)
                t[i] = data[i];                
            data = t;
        }
        data[length++] = e;
        return true;
    }

    public boolean contains(Object o) {
        return indexOf(o) >= 0;
    }

//     public boolean containsAll(Collection<?> c) {
//         // sort data
//         // sort c
//     }

    // public boolean equals(Object o) {
    //     throw new Exception("WIP");
    // }

    @SuppressWarnings("unchecked")
    public E get(int index) {
        checkRange(index);
        return (E)data[index];
    }

    // public int hashCode() {
    //     throw new Exception("WIP");
    // }

    public int indexOf(Object o) {
        for(int i = 0; i < length; i++)
            if(data[i].equals(o))
                return i;
        return -1;
    }

    public boolean isEmpty() {
        return length == 0;
    }

    // public iterator() {
    //     throw new Exception("WIP");
    // }

    // public int lastIndexOf(Object o) {
    //     throw new Exception("WIP");
    // }

    // public ListIterator<E> listIterator() {
    //     throw new Exception("WIP");
    // }

    // public ListIterator<E> listIterator(int index) {
    //     throw new Exception("WIP");
    // }

    public E remove(int index) {
        checkRange(index);
        E e = get(index);
        length--;
        for(int i = index; i < length; i++)
            data[i] = data[i+1];
        data[length] = null;
        return e;
    }

    public boolean remove(Object o) {
        int index = indexOf(o);
        if(index == -1)
            return false;
        remove(index);
        return true;
    }

//     public boolean removeAll(Collection<?> c) {
//         throw new Exception("WIP");
//     }

    // public default void replaceAll(UnaryOperator<E> operator) {
    //     throw new Exception("WIP");
    // }

    public int size() {
        return length;
    }

    // public default void sort(Comparator<? super E> c) {
    //     throw new Exception("WIP");
    // }

    // public default Spliterator<E> spliterator() {
    //     throw new Exception("WIP");
    // }

    // public List<E> sublist(int fromIndex, int toIndex) {
    //     throw new Exception("WIP");
    // }

    // public Object[] toArray() {
    //     throw new Exception("WIP");
    // }

    // public <T> T[] toArray(T[] a) {
    //     throw new Exception("WIP");
    // }

    private void checkRange(int index) {
        if(index >= length)
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + length);
    }
}
