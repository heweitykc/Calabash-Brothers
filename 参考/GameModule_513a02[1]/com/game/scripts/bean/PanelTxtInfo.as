package com.game.scripts.bean
{
    import net.*;

    public class PanelTxtInfo extends Bean
    {
        private var _name:String;
        private var _type:int;
        private var _content:String;

        public function PanelTxtInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._name);
            writeByte(this._type);
            writeString(this._content);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._name = readString();
            this._type = readByte();
            this._content = readString();
            return true;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
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

        public function get content() : String
        {
            return this._content;
        }// end function

        public function set content(param1:String) : void
        {
            this._content = param1;
            return;
        }// end function

    }
}
