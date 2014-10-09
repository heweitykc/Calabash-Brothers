package com.game.task.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqConqueryTaskTransMessage extends Message
    {
        private var _taskId:long;
        private var _mapid:int;
        private var _x:int;
        private var _y:int;
        private var _line:int;
        private var _transtype:int;

        public function ReqConqueryTaskTransMessage()
        {
            return;
        }// end function

        public function get transtype() : int
        {
            return this._transtype;
        }// end function

        public function set transtype(param1:int) : void
        {
            this._transtype = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._taskId);
            writeInt(this._mapid);
            writeInt(this._x);
            writeInt(this._y);
            writeInt(this._line);
            writeByte(this._transtype);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._taskId = readLong();
            this._mapid = readInt();
            this._x = readInt();
            this._y = readInt();
            this._line = readInt();
            this._transtype = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120211;
        }// end function

        public function get taskId() : long
        {
            return this._taskId;
        }// end function

        public function set taskId(param1:long) : void
        {
            this._taskId = param1;
            return;
        }// end function

        public function get mapid() : int
        {
            return this._mapid;
        }// end function

        public function set mapid(param1:int) : void
        {
            this._mapid = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get line() : int
        {
            return this._line;
        }// end function

        public function set line(param1:int) : void
        {
            this._line = param1;
            return;
        }// end function

    }
}
