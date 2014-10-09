package com.game.gradegift.message
{
    import __AS3__.vec.*;
    import com.game.gradegift.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResGradeGiftMessage extends Message
    {
        private var _startTime:long;
        private var _endTime:long;
        private var _surplusTime:int;
        private var _awardInfo:Vector.<GradeGiftInfo>;
        private var _gainAwardInfo:Vector.<GainGradeGiftInfo>;

        public function ResGradeGiftMessage()
        {
            this._awardInfo = new Vector.<GradeGiftInfo>;
            this._gainAwardInfo = new Vector.<GainGradeGiftInfo>;
            return;
        }// end function

        public function set startTime(param1:long) : void
        {
            this._startTime = param1;
            return;
        }// end function

        public function get startTime() : long
        {
            return this._startTime;
        }// end function

        public function set endTime(param1:long) : void
        {
            this._endTime = param1;
            return;
        }// end function

        public function get endTime() : long
        {
            return this._endTime;
        }// end function

        public function set surplusTime(param1:int) : void
        {
            this._surplusTime = param1;
            return;
        }// end function

        public function get surplusTime() : int
        {
            return this._surplusTime;
        }// end function

        public function set awardInfo(param1:Vector.<GradeGiftInfo>) : void
        {
            this._awardInfo = param1;
            return;
        }// end function

        public function get awardInfo() : Vector.<GradeGiftInfo>
        {
            return this._awardInfo;
        }// end function

        public function set gainAwardInfo(param1:Vector.<GainGradeGiftInfo>) : void
        {
            this._gainAwardInfo = param1;
            return;
        }// end function

        public function get gainAwardInfo() : Vector.<GainGradeGiftInfo>
        {
            return this._gainAwardInfo;
        }// end function

        override public function getId() : int
        {
            return 600004;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._startTime);
            writeLong(this._endTime);
            writeInt(this._surplusTime);
            writeShort(this._awardInfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._awardInfo.length)
            {
                
                writeBean(this._awardInfo[_loc_1]);
                _loc_1++;
            }
            writeShort(this._gainAwardInfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._gainAwardInfo.length)
            {
                
                writeBean(this._gainAwardInfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._startTime = readLong();
            this._endTime = readLong();
            this._surplusTime = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._awardInfo[_loc_2] = readBean(GradeGiftInfo) as GradeGiftInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._gainAwardInfo[_loc_2] = readBean(GainGradeGiftInfo) as GainGradeGiftInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
