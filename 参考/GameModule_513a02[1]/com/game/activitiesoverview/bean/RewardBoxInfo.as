package com.game.activitiesoverview.bean
{
    import net.*;

    public class RewardBoxInfo extends Bean
    {
        private var _id:int;
        private var _state:int;

        public function RewardBoxInfo()
        {
            return;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function set state(param1:int) : void
        {
            this._state = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function set id(param1:int) : void
        {
            this._id = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._id);
            writeShort(this._state);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._id = readShort();
            this._state = readShort();
            return true;
        }// end function

    }
}
