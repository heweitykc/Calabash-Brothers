package com.game.task.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqTaskFinshMessage extends Message
    {
        private var _type:int;
        private var _twice:Boolean;
        private var _conquererTaskId:long;
        private var _taskId:int;

        public function ReqTaskFinshMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeLong(this._conquererTaskId);
            writeInt(this._taskId);
            writeByte(this._twice ? (1) : (0));
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._conquererTaskId = readLong();
            this._taskId = readInt();
            this._twice = readByte() == 1;
            return true;
        }// end function

        override public function getId() : int
        {
            return 120202;
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

        public function get conquererTaskId() : long
        {
            return this._conquererTaskId;
        }// end function

        public function set conquererTaskId(param1:long) : void
        {
            this._conquererTaskId = param1;
            return;
        }// end function

        public function get taskId() : int
        {
            return this._taskId;
        }// end function

        public function set taskId(param1:int) : void
        {
            this._taskId = param1;
            return;
        }// end function

        public function get twice() : Boolean
        {
            return this._twice;
        }// end function

        public function set twice(param1:Boolean) : void
        {
            this._twice = param1;
            return;
        }// end function

    }
}
