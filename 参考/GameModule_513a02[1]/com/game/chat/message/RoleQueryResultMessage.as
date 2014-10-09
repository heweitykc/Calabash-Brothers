package com.game.chat.message
{
    import __AS3__.vec.*;
    import com.game.chat.bean.*;
    import net.*;

    public class RoleQueryResultMessage extends Message
    {
        private var _page:int;
        private var _count:int;
        private var _list:Vector.<RoleChatInfo>;

        public function RoleQueryResultMessage()
        {
            this._list = new Vector.<RoleChatInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._page);
            writeInt(this._count);
            writeShort(this._list.length);
            _loc_1 = 0;
            while (_loc_1 < this._list.length)
            {
                
                writeBean(this._list[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._page = readInt();
            this._count = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._list[_loc_1] = readBean(RoleChatInfo) as RoleChatInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 111102;
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

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get list() : Vector.<RoleChatInfo>
        {
            return this._list;
        }// end function

        public function set list(param1:Vector.<RoleChatInfo>) : void
        {
            this._list = param1;
            return;
        }// end function

    }
}
