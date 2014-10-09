package com.game.maze.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRewardMessage extends Message
    {
        private var _npc:long;
        private var _sort:int;
        private var _time:int;
        private var _bindgold:int;
        private var _exp:int;
        private var _zhenqi:int;

        public function ResRewardMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._npc);
            writeInt(this._sort);
            writeInt(this._time);
            writeInt(this._bindgold);
            writeInt(this._exp);
            writeInt(this._zhenqi);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._npc = readLong();
            this._sort = readInt();
            this._time = readInt();
            this._bindgold = readInt();
            this._exp = readInt();
            this._zhenqi = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 145102;
        }// end function

        public function get npc() : long
        {
            return this._npc;
        }// end function

        public function set npc(param1:long) : void
        {
            this._npc = param1;
            return;
        }// end function

        public function get sort() : int
        {
            return this._sort;
        }// end function

        public function set sort(param1:int) : void
        {
            this._sort = param1;
            return;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get bindgold() : int
        {
            return this._bindgold;
        }// end function

        public function set bindgold(param1:int) : void
        {
            this._bindgold = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get zhenqi() : int
        {
            return this._zhenqi;
        }// end function

        public function set zhenqi(param1:int) : void
        {
            this._zhenqi = param1;
            return;
        }// end function

    }
}
