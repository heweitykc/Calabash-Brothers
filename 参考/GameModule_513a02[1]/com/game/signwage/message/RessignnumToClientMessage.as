package com.game.signwage.message
{
    import net.*;

    public class RessignnumToClientMessage extends Message
    {
        private var _signnum:int;

        public function RessignnumToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._signnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._signnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 152104;
        }// end function

        public function get signnum() : int
        {
            return this._signnum;
        }// end function

        public function set signnum(param1:int) : void
        {
            this._signnum = param1;
            return;
        }// end function

    }
}
