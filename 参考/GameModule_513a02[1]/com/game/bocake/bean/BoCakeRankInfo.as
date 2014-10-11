package com.game.bocake.bean
{
    import net.*;

    public class BoCakeRankInfo extends Bean
    {
        private var _name:String;
        private var _fraction:int;

        public function BoCakeRankInfo()
        {
            return;
        }// end function

        public function get fraction() : int
        {
            return this._fraction;
        }// end function

        public function set fraction(param1:int) : void
        {
            this._fraction = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.name);
            writeInt(this.fraction);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.name = readString();
            this.fraction = readInt();
            return true;
        }// end function

    }
}
