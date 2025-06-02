import static org.junit.Assert.assertEquals;

import org.junit.Test;

import components.set.Set;

/**
 * JUnit test fixture for {@code Set<String>}'s constructor and kernel methods.
 *
 * @author Lucky Katneni and Trent Jackson
 *
 */
public abstract class SetTest {

    /**
     * Invokes the appropriate {@code Set} constructor for the implementation
     * under test and returns the result.
     *
     * @return the new set
     * @ensures constructorTest = {}
     */
    protected abstract Set<String> constructorTest();

    /**
     * Invokes the appropriate {@code Set} constructor for the reference
     * implementation and returns the result.
     *
     * @return the new set
     * @ensures constructorRef = {}
     */
    protected abstract Set<String> constructorRef();

    /**
     * Creates and returns a {@code Set<String>} of the implementation under
     * test type with the given entries.
     *
     * @param args
     *            the entries for the set
     * @return the constructed set
     * @requires [every entry in args is unique]
     * @ensures createFromArgsTest = [entries in args]
     */
    private Set<String> createFromArgsTest(String... args) {
        Set<String> set = this.constructorTest();
        for (String s : args) {
            assert !set.contains(
                    s) : "Violation of: every entry in args is unique";
            set.add(s);
        }
        return set;
    }

    /**
     * Creates and returns a {@code Set<String>} of the reference implementation
     * type with the given entries.
     *
     * @param args
     *            the entries for the set
     * @return the constructed set
     * @requires [every entry in args is unique]
     * @ensures createFromArgsRef = [entries in args]
     */
    private Set<String> createFromArgsRef(String... args) {
        Set<String> set = this.constructorRef();
        for (String s : args) {
            assert !set.contains(
                    s) : "Violation of: every entry in args is unique";
            set.add(s);
        }
        return set;
    }

    // TODO - add test cases for constructor, add, remove, removeAny, contains, and size

    @Test
    public void testOfConstructor() {

        Set<String> testUnit = this.createFromArgsTest();
        Set<String> refUnit = this.createFromArgsRef();

        assertEquals(refUnit, testUnit);
    }

    @Test
    public void addTest_Empty() {

        Set<String> testUnit = this.createFromArgsTest();
        Set<String> refUnit = this.createFromArgsRef();

        testUnit.add("Test");
        refUnit.add("Test");

        assertEquals(refUnit, testUnit);
    }

    @Test
    public void addTest_NonEmpty() {

        Set<String> testUnit = this.createFromArgsTest("Set", "BST");
        Set<String> refUnit = this.createFromArgsRef("Set", "BST");

        testUnit.add("Test");
        refUnit.add("Test");

        assertEquals(refUnit, testUnit);
    }

    @Test
    public void removeTest_Empty() {

        Set<String> testUnit = this.createFromArgsTest("Test");
        Set<String> refUnit = this.createFromArgsRef("Test");

        String testString = testUnit.remove("Test");
        String refString = refUnit.remove("Test");

        assertEquals(refString, testString);
        assertEquals(refUnit, testUnit);
    }

    @Test
    public void removeTest_NonEmpty() {

        Set<String> testUnit = this.createFromArgsTest("Set", "BST");
        Set<String> refUnit = this.createFromArgsRef("Set", "BST");

        String testString = testUnit.remove("Set");
        String refString = refUnit.remove("Set");

        assertEquals(refString, testString);
        assertEquals(refUnit, testUnit);
    }

    @Test
    public void removeAnyTest_NonEmpty() {

        Set<String> testUnit = this.createFromArgsTest("Set");
        Set<String> refUnit = this.createFromArgsRef("Set");

        String testString = testUnit.removeAny();
        assert (refUnit.contains(testString));
        refUnit.remove(testString);

        assertEquals(refUnit, testUnit);
    }

    @Test
    public void removeAnyTest_Empty() {

        Set<String> testUnit = this.createFromArgsTest("Set", "BST");
        Set<String> refUnit = this.createFromArgsRef("Set", "BST");

        String testString = testUnit.removeAny();
        assert (refUnit.contains(testString));
        refUnit.remove(testString);

        assertEquals(refUnit, testUnit);
    }

    @Test
    public void containsTest_Empty() {

        Set<String> testUnit = this.createFromArgsTest();
        Set<String> refUnit = this.createFromArgsRef();

        boolean testContains = testUnit.contains("Test");

        assertEquals(false, testContains);
        assertEquals(refUnit, testUnit);
    }

    @Test
    public void containsTest_False() {

        Set<String> testUnit = this.createFromArgsTest("Set", "BST");
        Set<String> refUnit = this.createFromArgsRef("Set", "BST");

        boolean testContains = testUnit.contains("Test");

        assertEquals(false, testContains);
        assertEquals(refUnit, testUnit);
    }

    @Test
    public void containsTest_True() {

        Set<String> testUnit = this.createFromArgsTest("Set", "BST");
        Set<String> refUnit = this.createFromArgsRef("Set", "BST");

        boolean testContains = testUnit.contains("Set");

        assertEquals(true, testContains);
        assertEquals(refUnit, testUnit);
    }

    @Test
    public void sizeTest_0() {

        Set<String> testUnit = this.createFromArgsTest();
        Set<String> refUnit = this.createFromArgsRef();

        int testSize = testUnit.size();

        assertEquals(0, testSize);
        assertEquals(refUnit, testUnit);
    }

    @Test
    public void sizeTest_2() {

        Set<String> testUnit = this.createFromArgsTest("Set", "BST");
        Set<String> refUnit = this.createFromArgsRef("Set", "BST");

        int testSize = testUnit.size();

        assertEquals(2, testSize);
        assertEquals(refUnit, testUnit);
    }

}
