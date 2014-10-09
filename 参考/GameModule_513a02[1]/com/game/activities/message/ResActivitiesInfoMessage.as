package com.game.activities.message
{
    import __AS3__.vec.*;
    import com.game.activities.bean.*;
    import net.*;

    public class ResActivitiesInfoMessage extends Message
    {
        private var _activities:Vector.<ActivityInfo>;

        public function ResActivitiesInfoMessage()
        {
            this._activities = new Vector.<ActivityInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._activities.length);
            _loc_1 = 0;
            while (_loc_1 < this._activities.length)
            {
                
                writeBean(this._activities[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._activities[_loc_1] = readBean(ActivityInfo) as ActivityInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 138101;
        }// end function

        public function get activities() : Vector.<ActivityInfo>
        {
            return this._activities;
        }// end function

        public function set activities(param1:Vector.<ActivityInfo>) : void
        {
            this._activities = param1;
            return;
        }// end function

    }
}
