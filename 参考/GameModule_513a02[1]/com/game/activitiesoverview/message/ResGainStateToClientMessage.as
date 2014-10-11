package com.game.activitiesoverview.message
{
    import __AS3__.vec.*;
    import com.game.activitiesoverview.bean.*;
    import net.*;

    public class ResGainStateToClientMessage extends Message
    {
        private var _boxes:Vector.<RewardBoxInfo>;

        public function ResGainStateToClientMessage()
        {
            this._boxes = new Vector.<RewardBoxInfo>;
            return;
        }// end function

        public function get boxes() : Vector.<RewardBoxInfo>
        {
            return this._boxes;
        }// end function

        public function set boxes(param1:Vector.<RewardBoxInfo>) : void
        {
            this._boxes = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._boxes.length);
            _loc_1 = 0;
            while (_loc_1 < this._boxes.length)
            {
                
                writeBean(this._boxes[_loc_1]);
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
                
                this._boxes[_loc_1] = readBean(RewardBoxInfo) as RewardBoxInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 600107;
        }// end function

    }
}
