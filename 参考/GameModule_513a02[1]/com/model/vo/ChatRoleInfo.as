package com.model.vo
{
    import com.game.chat.bean.*;
    import com.game.utils.*;

    public class ChatRoleInfo extends Object
    {
        private var _id:long;
        public var index:int;
        private var _name:String;
        private var _level:int;

        public function ChatRoleInfo(param1:RoleChatInfo = null)
        {
            if (param1)
            {
                this._id = param1.id;
                this._name = param1.name;
                this._level = param1.level;
            }
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
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

        public function get id() : long
        {
            return this._id;
        }// end function

        public function set id(param1:long) : void
        {
            this._id = param1;
            return;
        }// end function

    }
}
