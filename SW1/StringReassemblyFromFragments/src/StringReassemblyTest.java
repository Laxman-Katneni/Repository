import static org.junit.Assert.assertEquals;

import org.junit.Test;

import components.set.Set;
import components.set.Set2;
import components.simplereader.SimpleReader;
import components.simplereader.SimpleReader1L;
import components.simplewriter.SimpleWriter;
import components.simplewriter.SimpleWriter1L;

public class StringReassemblyTest {

    @Test

    public final void testAddToSetAvoidingSubstrings() {
        Set<String> s1 = new Set2<String>();
        s1.add("Letters");
        s1.add("Alphabets");
        s1.add("words");

        StringReassembly.addToSetAvoidingSubstrings(s1, "etter");

        Set<String> s1Expected = new Set2<String>();
        s1Expected.add("Letters");
        s1Expected.add("Alphabets");
        s1Expected.add("words");
        assertEquals(s1Expected, s1);

    }

    @Test

    public final void testAddToSetAvoidingSubstrings234() {
        Set<String> s1 = new Set2<String>();
        s1.add("Letters");
        s1.add("Al234bets");
        s1.add("words");

        StringReassembly.addToSetAvoidingSubstrings(s1, "234");

        Set<String> s1Expected = new Set2<String>();
        s1Expected.add("Letters");
        s1Expected.add("Al234bets");
        s1Expected.add("words");

        assertEquals(s1Expected, s1);

    }

    @Test
    public final void testAddToSetAvoidingSubstringsdiif() { // for string which is not a substring
        Set<String> s1 = new Set2<String>();
        s1.add("Letters");
        s1.add("Al234bets");
        s1.add("words");

        StringReassembly.addToSetAvoidingSubstrings(s1, "235");

        Set<String> s1Expected = new Set2<String>();
        s1Expected.add("Letters");
        s1Expected.add("Al234bets");
        s1Expected.add("words");
        s1Expected.add("235");

        assertEquals(s1Expected, s1);

    }

    @Test

    public final void testLinesFromInput() {

        SimpleWriter out = new SimpleWriter1L("file.txt");

        out.print("Line1\nLine2\nLine3");

        SimpleReader in = new SimpleReader1L("file.txt");

        Set<String> s1 = StringReassembly.linesFromInput(in);

        Set<String> s1Expected = new Set2<String>();
        s1Expected.add("Line1");
        s1Expected.add("Line2");
        s1Expected.add("Line3");

        assertEquals(s1Expected, s1);

    }

    @Test

    public final void testCombination() { // general test case

        String str1 = "Apple";
        String str2 = "letter";

        String result = StringReassembly.combination(str1, str2, 2);

        String resultExpected = "Appletter";

        assertEquals(resultExpected, result);

    }

    @Test

    public final void testCombination_2() { // test to see whether it adds at the end or in the middle

        String str1 = "App";
        String str2 = "ple";

        String result = StringReassembly.combination(str1, str2, 1);

        String resultExpected = "Apple";

        assertEquals(resultExpected, result);

    }

}
