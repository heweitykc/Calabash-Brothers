package com.game.challenge.bean
{
    import net.*;

    public class ChallengeRewardInfo extends Bean
    {
        private var _id:int;
        private var _num:int;
        private var _type:int;

        public function ChallengeRewardInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._id);
            writeInt(this._num);
            writeInt(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._id = readInt();
            this._num = readInt();
            this._type = readInt();
            return true;
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

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
