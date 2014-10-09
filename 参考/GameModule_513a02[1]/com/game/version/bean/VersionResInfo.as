package com.game.version.bean
{
    import net.*;

    public class VersionResInfo extends Bean
    {
        private var _version:int;
        private var _tabname:String;

        public function VersionResInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._version);
            writeString(this._tabname);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._version = readInt();
            this._tabname = readString();
            return true;
        }// end function

        public function get version() : int
        {
            return this._version;
        }// end function

        public function set version(param1:int) : void
        {
            this._version = param1;
            return;
        }// end function

        public function get tabname() : String
        {
            return this._tabname;
        }// end function

        public function set tabname(param1:String) : void
        {
            this._tabname = param1;
            return;
        }// end function

    }
}
