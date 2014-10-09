package com.game.chestbox.message
{
    import net.*;

    public class ResChestBoxChooseInfoToClientMessage extends Message
    {
        private var _opennum:int;
        private var _inchooseidx:int;
        private var _outchooseidx:int;
        private var _chooseOutSideToInSide:int;

        public function ResChestBoxChooseInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._opennum);
            writeInt(this._inchooseidx);
            writeInt(this._outchooseidx);
            writeInt(this._chooseOutSideToInSide);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._opennum = readInt();
            this._inchooseidx = readInt();
            this._outchooseidx = readInt();
            this._chooseOutSideToInSide = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 156102;
        }// end function

        public function get opennum() : int
        {
            return this._opennum;
        }// end function

        public function set opennum(param1:int) : void
        {
            this._opennum = param1;
            return;
        }// end function

        public function get inchooseidx() : int
        {
            return this._inchooseidx;
        }// end function

        public function set inchooseidx(param1:int) : void
        {
            this._inchooseidx = param1;
            return;
        }// end function

        public function get outchooseidx() : int
        {
            return this._outchooseidx;
        }// end function

        public function set outchooseidx(param1:int) : void
        {
            this._outchooseidx = param1;
            return;
        }// end function

        public function get chooseOutSideToInSide() : int
        {
            return this._chooseOutSideToInSide;
        }// end function

        public function set chooseOutSideToInSide(param1:int) : void
        {
            this._chooseOutSideToInSide = param1;
            return;
        }// end function

    }
}
