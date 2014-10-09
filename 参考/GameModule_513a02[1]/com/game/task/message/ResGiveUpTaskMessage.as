package com.game.task.message
{
    import com.game.utils.*;
    import net.*;

    public class ResGiveUpTaskMessage extends Message
    {
        private var _type:int;
        private var _taskid:long;

        public function ResGiveUpTaskMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeLong(this._taskid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._taskid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120112;
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

        public function get taskid() : long
        {
            return this._taskid;
        }// end function

        public function set taskid(param1:long) : void
        {
            this._taskid = param1;
            return;
        }// end function

    }
}
