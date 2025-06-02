import static org.junit.Assert.assertEquals;

import org.junit.Test;

import components.naturalnumber.NaturalNumber;
import components.naturalnumber.NaturalNumber2;

/**
 * JUnit test fixture for {@code NaturalNumber}'s constructors and kernel
 * methods.
 *
 * @author Put your name here
 *
 */
public abstract class NaturalNumberTest {

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * implementation under test and returns the result.
     *
     * @return the new number
     * @ensures constructorTest = 0
     */
    protected abstract NaturalNumber constructorTest();

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * implementation under test and returns the result.
     *
     * @param i
     *            {@code int} to initialize from
     * @return the new number
     * @requires i >= 0
     * @ensures constructorTest = i
     */
    protected abstract NaturalNumber constructorTest(int i);

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * implementation under test and returns the result.
     *
     * @param s
     *            {@code String} to initialize from
     * @return the new number
     * @requires there exists n: NATURAL (s = TO_STRING(n))
     * @ensures s = TO_STRING(constructorTest)
     */
    protected abstract NaturalNumber constructorTest(String s);

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * implementation under test and returns the result.
     *
     * @param n
     *            {@code NaturalNumber} to initialize from
     * @return the new number
     * @ensures constructorTest = n
     */
    protected abstract NaturalNumber constructorTest(NaturalNumber n);

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * reference implementation and returns the result.
     *
     * @return the new number
     * @ensures constructorRef = 0
     */
    protected abstract NaturalNumber constructorRef();

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * reference implementation and returns the result.
     *
     * @param i
     *            {@code int} to initialize from
     * @return the new number
     * @requires i >= 0
     * @ensures constructorRef = i
     */
    protected abstract NaturalNumber constructorRef(int i);

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * reference implementation and returns the result.
     *
     * @param s
     *            {@code String} to initialize from
     * @return the new number
     * @requires there exists n: NATURAL (s = TO_STRING(n))
     * @ensures s = TO_STRING(constructorRef)
     */
    protected abstract NaturalNumber constructorRef(String s);

    /**
     * Invokes the appropriate {@code NaturalNumber} constructor for the
     * reference implementation and returns the result.
     *
     * @param n
     *            {@code NaturalNumber} to initialize from
     * @return the new number
     * @ensures constructorRef = n
     */
    protected abstract NaturalNumber constructorRef(NaturalNumber n);

    // TODO - add test cases for four constructors, multiplyBy10, divideBy10, isZero
    @Test
    public void testOfConstructor_Null() {

        NaturalNumber testUnit = this.constructorTest();
        NaturalNumber refUnit = this.constructorRef();
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void testOfConstructor_7int() {

        int i = 7;
        NaturalNumber testUnit = this.constructorTest(i);
        NaturalNumber refUnit = this.constructorRef(i);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void testOfConstructor_0int() {

        int i = 0;
        NaturalNumber testUnit = this.constructorTest(i);
        NaturalNumber refUnit = this.constructorRef(i);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void testOfConstructor_String() {

        String s = "123";
        NaturalNumber testUnit = this.constructorTest(s);
        NaturalNumber refUnit = this.constructorRef(s);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void testOfConstructor_EmptyString() {

        String s = "";
        NaturalNumber testUnit = this.constructorTest(s);
        NaturalNumber refUnit = this.constructorRef(s);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void testOfConstructor_7NN() {

        NaturalNumber n = new NaturalNumber2(7);
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void testOfConstructor_0NN() {

        NaturalNumber n = new NaturalNumber2(0);
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void multiplyBy10Test_0_0() {

        NaturalNumber n = new NaturalNumber2(0);
        int i = 0;
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        testUnit.multiplyBy10(i);
        refUnit.multiplyBy10(i);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void multiplyBy10Test_0_7() {

        NaturalNumber n = new NaturalNumber2(0);
        int i = 7;
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        testUnit.multiplyBy10(i);
        refUnit.multiplyBy10(i);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void multiplyBy10Test_4_7() {

        NaturalNumber n = new NaturalNumber2(4);
        int i = 7;
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        testUnit.multiplyBy10(i);
        refUnit.multiplyBy10(i);
        assertEquals(testUnit, refUnit);
    }

    @Test
    public void divideBy10Test_7() {

        NaturalNumber n = new NaturalNumber2(7);
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        int i = testUnit.divideBy10();
        int j = refUnit.divideBy10();
        assertEquals(testUnit, refUnit);
        assertEquals(i, j);
    }

    @Test
    public void divideBy10Test_45() {

        NaturalNumber n = new NaturalNumber2(45);
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        int i = testUnit.divideBy10();
        int j = refUnit.divideBy10();
        assertEquals(testUnit, refUnit);
        assertEquals(i, j);
    }

    @Test
    public void isZeroTest_True() {

        NaturalNumber n = new NaturalNumber2(0);
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        boolean testZero = testUnit.isZero();
        boolean refZero = refUnit.isZero();
        assertEquals(testUnit, refUnit);
        assertEquals(testZero, true);
        assertEquals(refZero, true);
    }

    @Test
    public void isZeroTest_False() {

        NaturalNumber n = new NaturalNumber2(1);
        NaturalNumber testUnit = this.constructorTest(n);
        NaturalNumber refUnit = this.constructorRef(n);
        boolean testZero = testUnit.isZero();
        boolean refZero = refUnit.isZero();
        assertEquals(testUnit, refUnit);
        assertEquals(testZero, false);
        assertEquals(refZero, false);
    }

}
