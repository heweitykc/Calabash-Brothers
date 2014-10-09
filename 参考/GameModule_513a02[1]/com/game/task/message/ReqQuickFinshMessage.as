package com.game.task.message
{
    import net.*;

    public class ReqQuickFinshMessage extends Message
    {
        private var _taskId:int;
        private var _type:int;

        public function ReqQuickFinshMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._taskId);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._taskId = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120206;
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
