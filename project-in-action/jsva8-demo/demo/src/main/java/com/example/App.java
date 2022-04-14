package com.example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Hello world!
 */
public final class App {
    private App() {
    }

    /**
     * Says hello to the world.
     * 
     * @param args The arguments of the program.
     */
    public static void main(String[] args) {
        System.out.println("Start!");

        List<Object[]> aList = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            Object[] a = { 0, 0, 0, 0 };
            a[0] = i + 1;
            a[1] = i + 1;
            a[2] = i + 1;
            a[3] = i + 1;
            aList.add(a);
        }
        for (int i = 0; i < 2; i++) {
            Object[] a = { 0, 0, 0, 0 };
            a[0] = i + 20;
            a[1] = i + 1;
            a[2] = i + 1;
            a[3] = i + 1;
            aList.add(a);
        }

        List<Object[]> bList = new ArrayList<>();
        for (int i = 3; i < 8; i++) {
            Object[] a = { 0, 0, 0, 0 };
            a[0] = i + 1;
            a[1] = i + 1;
            a[2] = i + 1;
            a[3] = i + 1;
            bList.add(a);
        }
        for (int i = 0; i < 2; i++) {
            Object[] a = { 0, 0, 0, 0 };
            a[0] = i + 20;
            a[1] = i + 2;
            a[2] = i + 3;
            a[3] = i + 4;
            bList.add(a);
        }

        List<Object[]> intersectionList = new ArrayList<>();
        List<Object[]> differenceSetOldList = new ArrayList<>();
        List<Object[]> differenceSetNewList = new ArrayList<>();
        objectArray(aList, bList, intersectionList, differenceSetOldList, differenceSetNewList);

        System.out.println("End!");
    }

    static void objectArray(List<Object[]> oldList, List<Object[]> newList, List<Object[]> intersectionList,
            List<Object[]> differenceSetOldList, List<Object[]> differenceSetNewList) {
        // 取交集
        List<Object[]> intersectionListT = newList.stream().filter(a -> oldList.stream().map(b -> b[0])
                .collect(Collectors.toList()).contains(a[0]) &&
                !Arrays.equals(a, oldList.stream()
                        .collect(Collectors.toMap((c) -> c[0], Function.identity(), (key1, key2) -> key2)).get(a[0])))
                .collect(Collectors.toList());
        System.out.println("交集" + intersectionListT);
        intersectionList.addAll(intersectionListT);

        // A差集
        List<Object[]> differenceSetOldListT = oldList.stream()
                .filter(a -> !newList.stream().map(b -> b[0]).collect(Collectors.toList()).contains(a[0]))
                .collect(Collectors.toList());
        System.out.println("A差集" + differenceSetOldListT);
        differenceSetOldList.addAll(differenceSetOldListT);

        // B差集
        List<Object[]> differenceSetNewListT = newList.stream()
                .filter(b -> !oldList.stream().map(a -> a[0]).collect(Collectors.toList()).contains(b[0]))
                .collect(Collectors.toList());
        System.out.println("B差集" + differenceSetNewListT);
        differenceSetNewList.addAll(differenceSetNewListT);
    }
}
