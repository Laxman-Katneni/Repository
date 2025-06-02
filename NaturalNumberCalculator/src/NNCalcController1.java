import components.naturalnumber.NaturalNumber;
import components.naturalnumber.NaturalNumber2;

/**
 * Controller class.
 *
 * @author Laxman Katneni
 */
public final class NNCalcController1 implements NNCalcController {

    /**
     * Model object.
     */
    private final NNCalcModel model;

    /**
     * View object.
     */
    private final NNCalcView view;

    /**
     * Useful constants.
     */
    private static final NaturalNumber TWO = new NaturalNumber2(2),
            INT_LIMIT = new NaturalNumber2(Integer.MAX_VALUE);

    /**
     * Updates this.view to display this.model, and to allow only operations
     * that are legal given this.model.
     *
     * @param model
     *            the model
     * @param view
     *            the view
     * @ensures [view has been updated to be consistent with model]
     */
    private static void updateViewToMatchModel(NNCalcModel model,
            NNCalcView view) {

        
        NaturalNumber top = model.top();
        NaturalNumber bottom = model.bottom();

        // Check for subtraction
        if (top.compareTo(bottom) >= 0) {
            view.updateSubtractAllowed(true);
        } else {
            view.updateSubtractAllowed(false);
        }
        //Check for division
        if (!bottom.isZero()) {
            view.updateDivideAllowed(true);
        } else {
            view.updateDivideAllowed(false);
        }
        // Check for root
        if (bottom.compareTo(TWO) < 0 && bottom.compareTo(INT_LIMIT) > 0) {
            view.updateRootAllowed(false);
        } else {
            view.updateRootAllowed(true);
        }
        // Check for power
        if (bottom.compareTo(INT_LIMIT) > 0) {
            view.updatePowerAllowed(false);
        } else {
            view.updatePowerAllowed(true);
        }

        view.updateTopDisplay(top); // To accommodate for the changes made
        view.updateBottomDisplay(bottom);

    }

    /**
     * Constructor.
     *
     * @param model
     *            model to connect to
     * @param view
     *            view to connect to
     */
    public NNCalcController1(NNCalcModel model, NNCalcView view) {
        this.model = model;
        this.view = view;
        updateViewToMatchModel(model, view);
    }

    @Override
    public void processClearEvent() {
        /*
         * Get alias to bottom from model
         */
        NaturalNumber bottom = this.model.bottom();
        /*
         * Update model in response to this event
         */
        bottom.clear();
        /*
         * Update view to reflect changes in model
         */
        updateViewToMatchModel(this.model, this.view);
    }

    @Override
    public void processSwapEvent() {
        /*
         * Get aliases to top and bottom from model
         */
        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();
        /*
         * Update model in response to this event
         */
        NaturalNumber temp = top.newInstance();
        temp.transferFrom(top);
        top.transferFrom(bottom);
        bottom.transferFrom(temp);
        /*
         * Update view to reflect changes in model
         */
        updateViewToMatchModel(this.model, this.view);
    }

    @Override
    public void processEnterEvent() {

        
        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();

        // Event
        top.copyFrom(bottom);

        // Update
        updateViewToMatchModel(this.model, this.view);

    }

    @Override
    public void processAddEvent() {

       
        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();

        // Event
        bottom.add(top);
        top.clear();

        // Update
        updateViewToMatchModel(this.model, this.view);

    }

    @Override
    public void processSubtractEvent() {

       
        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();

        // Event
        top.subtract(bottom);
        bottom.copyFrom(top);
        top.clear();

        // Update
        updateViewToMatchModel(this.model, this.view);

    }

    @Override
    public void processMultiplyEvent() {

     
        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();

        // Event
        top.multiply(bottom);
        bottom.copyFrom(top);
        top.clear();

        // Update
        updateViewToMatchModel(this.model, this.view);

    }

    @Override
    public void processDivideEvent() {

 
        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();

        // Event
        NaturalNumber remainder = top.divide(bottom);
        bottom.transferFrom(top);
        top.transferFrom(remainder);

        // Update
        updateViewToMatchModel(this.model, this.view);

    }

    @Override
    public void processPowerEvent() {

 
        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();

        // Event
        top.power(bottom.toInt());
        bottom.copyFrom(top);
        top.clear();

        // Update
        updateViewToMatchModel(this.model, this.view);
    }

    @Override
    public void processRootEvent() {

        NaturalNumber top = this.model.top();
        NaturalNumber bottom = this.model.bottom();

        // Event
        top.root(bottom.toInt());
        bottom.copyFrom(top);
        top.clear();

        //Update
        updateViewToMatchModel(this.model, this.view);
    }

    @Override
    public void processAddNewDigitEvent(int digit) {

        

        NaturalNumber bottom = this.model.bottom();

        //Event
        bottom.multiplyBy10(digit);

        //Update
        updateViewToMatchModel(this.model, this.view);

    }

}
