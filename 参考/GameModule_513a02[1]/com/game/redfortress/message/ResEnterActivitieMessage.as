package com.game.redfortress.message
{
    import net.*;

    public class ResEnterActivitieMessage extends Message
    {
        private var _type:int;

        public function ResEnterActivitieMessage()
        {
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        override public function getId() : int
        {
            return 550103;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            return true;
        }// end function

    }
}
