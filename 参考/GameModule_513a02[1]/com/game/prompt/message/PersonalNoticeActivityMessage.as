package com.game.prompt.message
{
    import __AS3__.vec.*;
    import net.*;

    public class PersonalNoticeActivityMessage extends Message
    {
        private var _type:String;
        private var _activityId:int;
        private var _content:String;
        private var _values:Vector.<String>;

        public function PersonalNoticeActivityMessage()
        {
            this._values = new Vector.<String>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeString(this._type);
            writeInt(this._activityId);
            writeString(this._content);
            writeShort(this._values.length);
            _loc_1 = 0;
            while (_loc_1 < this._values.length)
            {
                
                writeString(this._values[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._type = readString();
            this._activityId = readInt();
            this._content = readString();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._values[_loc_1] = readString();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 109111;
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

        public function get activityId() : int
        {
            return this._activityId;
        }// end function

        public function set activityId(param1:int) : void
        {
            this._activityId = param1;
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

        public function get values() : Vector.<String>
        {
            return this._values;
        }// end function

        public function set values(param1:Vector.<String>) : void
        {
            this._values = param1;
            return;
        }// end function

    }
}
