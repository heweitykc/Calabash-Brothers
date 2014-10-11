package com.game.prompt.message
{
    import __AS3__.vec.*;
    import com.game.chat.bean.*;
    import net.*;

    public class PersonalNoticeMessage extends Message
    {
        private var _type:String;
        private var _content:String;
        private var _subtype:int;
        private var _values:Vector.<String>;
        private var _goodsinfos:Vector.<GoodsInfoRes>;

        public function PersonalNoticeMessage()
        {
            this._values = new Vector.<String>;
            this._goodsinfos = new Vector.<GoodsInfoRes>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeString(this._type);
            writeString(this._content);
            writeInt(this._subtype);
            writeShort(this._values.length);
            _loc_1 = 0;
            while (_loc_1 < this._values.length)
            {
                
                writeString(this._values[_loc_1]);
                _loc_1++;
            }
            writeShort(this._goodsinfos.length);
            _loc_1 = 0;
            while (_loc_1 < this._goodsinfos.length)
            {
                
                writeBean(this._goodsinfos[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._type = readString();
            this._content = readString();
            this._subtype = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._values[_loc_1] = readString();
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._goodsinfos[_loc_1] = readBean(GoodsInfoRes) as GoodsInfoRes;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 109102;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
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

        public function get subtype() : int
        {
            return this._subtype;
        }// end function

        public function set subtype(param1:int) : void
        {
            this._subtype = param1;
            return;
        }// end function

        public function get values() : Vector.<String>
        {
            return this._values;
        }// end function

        public function set values(param1:Vector.<String>) : void
        {
            this._values = param1;
            return;
        }// end function

        public function get goodsinfos() : Vector.<GoodsInfoRes>
        {
            return this._goodsinfos;
        }// end function

        public function set goodsinfos(param1:Vector.<GoodsInfoRes>) : void
        {
            this._goodsinfos = param1;
            return;
        }// end function

    }
}
