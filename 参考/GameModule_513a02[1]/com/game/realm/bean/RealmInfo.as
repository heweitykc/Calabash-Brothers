package com.game.realm.bean
{
    import net.*;

    public class RealmInfo extends Bean
    {
        private var _realmlevel:int;
        private var _intensifylevel:int;
        private var _blessingnum:int;

        public function RealmInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._realmlevel);
            writeInt(this._intensifylevel);
            writeInt(this._blessingnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._realmlevel = readInt();
            this._intensifylevel = readInt();
            this._blessingnum = readInt();
            return true;
        }// end function

        public function get realmlevel() : int
        {
            return this._realmlevel;
        }// end function

        public function set realmlevel(param1:int) : void
        {
            this._realmlevel = param1;
            return;
        }// end function

        public function get intensifylevel() : int
        {
            return this._intensifylevel;
        }// end function

        public function set intensifylevel(param1:int) : void
        {
            this._intensifylevel = param1;
            return;
        }// end function

        public function get blessingnum() : int
        {
            return this._blessingnum;
        }// end function

        public function set blessingnum(param1:int) : void
        {
            this._blessingnum = param1;
            return;
        }// end function

    }
}
