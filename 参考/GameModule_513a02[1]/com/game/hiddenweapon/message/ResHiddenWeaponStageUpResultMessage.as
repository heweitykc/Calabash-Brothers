package com.game.hiddenweapon.message
{
    import net.*;

    public class ResHiddenWeaponStageUpResultMessage extends Message
    {
        private var _type:int;
        private var _bless:int;
        private var _gotbless:int;
        private var _gotexp:int;
        private var _crit:int;

        public function ResHiddenWeaponStageUpResultMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._bless);
            writeInt(this._gotbless);
            writeInt(this._gotexp);
            writeByte(this._crit);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._bless = readInt();
            this._gotbless = readInt();
            this._gotexp = readInt();
            this._crit = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 162104;
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

        public function get bless() : int
        {
            return this._bless;
        }// end function

        public function set bless(param1:int) : void
        {
            this._bless = param1;
            return;
        }// end function

        public function get gotbless() : int
        {
            return this._gotbless;
        }// end function

        public function set gotbless(param1:int) : void
        {
            this._gotbless = param1;
            return;
        }// end function

        public function get gotexp() : int
        {
            return this._gotexp;
        }// end function

        public function set gotexp(param1:int) : void
        {
            this._gotexp = param1;
            return;
        }// end function

        public function get crit() : int
        {
            return this._crit;
        }// end function

        public function set crit(param1:int) : void
        {
            this._crit = param1;
            return;
        }// end function

    }
}
