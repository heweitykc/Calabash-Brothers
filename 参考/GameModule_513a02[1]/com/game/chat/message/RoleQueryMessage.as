package com.game.chat.message
{
    import net.*;

    public class RoleQueryMessage extends Message
    {
        private var _page:int;
        private var _roleLikeName:String;
        private var _type:int;

        public function RoleQueryMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._page);
            writeString(this._roleLikeName);
            writeInt(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._page = readInt();
            this._roleLikeName = readString();
            this._type = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 111202;
        }// end function

        public function get page() : int
        {
            return this._page;
        }// end function

        public function set page(param1:int) : void
        {
            this._page = param1;
            return;
        }// end function

        public function get roleLikeName() : String
        {
            return this._roleLikeName;
        }// end function

        public function set roleLikeName(param1:String) : void
        {
            this._roleLikeName = param1;
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
