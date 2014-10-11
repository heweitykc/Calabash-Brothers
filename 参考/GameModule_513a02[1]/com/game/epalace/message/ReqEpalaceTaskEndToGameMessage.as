package com.game.epalace.message
{
    import net.*;

    public class ReqEpalaceTaskEndToGameMessage extends Message
    {
        private var _type:int;
        private var _taskid:int;

        public function ReqEpalaceTaskEndToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._taskid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._taskid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 143203;
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

        public function get taskid() : int
        {
            return this._taskid;
        }// end function

        public function set taskid(param1:int) : void
        {
            this._taskid = param1;
            return;
        }// end function

    }
}
