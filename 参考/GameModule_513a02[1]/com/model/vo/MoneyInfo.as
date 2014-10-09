package com.model.vo
{
    import com.staticdata.*;

    public class MoneyInfo extends Object
    {
        public var id:String;
        public var num:Number;
        public var name:String;
        public var tip:String;

        public function MoneyInfo()
        {
            return;
        }// end function

        public function get url() : String
        {
            return Params.ITEM_PATH + this.id + ".png";
        }// end function

    }
}
