package com.game.task.bean
{
    import net.*;

    public class RankTaskAttribute extends Bean
    {
        private var _type:int;
        private var _num:int;

        public function RankTaskAttribute()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._num = readInt();
            return true;
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

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

    }
}
