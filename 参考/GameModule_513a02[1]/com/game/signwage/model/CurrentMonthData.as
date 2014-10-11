package com.game.signwage.model
{
    import __AS3__.vec.*;
    import com.f1.*;

    public class CurrentMonthData extends BaseEventDispatcher
    {
        private var _calendarData:Array;
        private var _month:int = 1;
        private var _year:int = 30;
        private var _date:int = 0;
        private var _firstDayIndex:int = 0;
        private var _daysOfCurrentMonth:uint = 0;
        private var _hasCheckedinToday:Boolean = false;
        private var _beginDate:int = 1;

        public function CurrentMonthData(param1:uint, param2:uint, param3:uint)
        {
            var _loc_5:* = null;
            this._calendarData = [];
            var _loc_4:* = new Date(param1, (param2 - 1), 1);
            this._year = param1;
            this._month = param2;
            this._date = param3;
            this._firstDayIndex = _loc_4.getUTCDay();
            this._daysOfCurrentMonth = this.datesCount;
            var _loc_6:* = 0;
            while (_loc_6 < 31)
            {
                
                _loc_5 = {signed:false, date:(_loc_6 + 1)};
                this._calendarData.push(_loc_5);
                _loc_6++;
            }
            return;
        }// end function

        public function signUpOneDay(param1:int) : void
        {
            if (param1 > 31)
            {
                throw new Error("签到越界");
            }
            this._calendarData[(param1 - 1)].signed = true;
            return;
        }// end function

        public function isSigned(param1:int) : Boolean
        {
            if (param1 > 31)
            {
                throw new Error("越界");
            }
            return this._calendarData[(param1 - 1)].signed;
        }// end function

        public function isBeforeCreateTime(param1:int) : Boolean
        {
            return true;
        }// end function

        public function initData(param1:Vector.<int>, param2:int) : void
        {
            var _loc_3:* = 0;
            for each (_loc_3 in param1)
            {
                
                this.signUpOneDay(_loc_3);
            }
            this._beginDate = param2;
            return;
        }// end function

        private function get datesCount() : int
        {
            var _loc_1:* = 0;
            switch(this._month - 1)
            {
                case 0:
                {
                    _loc_1 = 31;
                    break;
                }
                case 1:
                {
                    _loc_1 = this._year % 4 == 0 ? (this._year % 100 == 0 && this._year % 400 != 0 ? (28) : (29)) : (28);
                    break;
                }
                case 2:
                {
                    _loc_1 = 31;
                    break;
                }
                case 3:
                {
                    _loc_1 = 30;
                    break;
                }
                case 4:
                {
                    _loc_1 = 31;
                    break;
                }
                case 5:
                {
                    _loc_1 = 30;
                    break;
                }
                case 6:
                {
                    _loc_1 = 31;
                    break;
                }
                case 7:
                {
                    _loc_1 = 31;
                    break;
                }
                case 8:
                {
                    _loc_1 = 30;
                    break;
                }
                case 9:
                {
                    _loc_1 = 31;
                    break;
                }
                case 10:
                {
                    _loc_1 = 30;
                    break;
                }
                case 11:
                {
                    _loc_1 = 31;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_1;
        }// end function

        public function get month() : int
        {
            return this._month;
        }// end function

        public function get year() : int
        {
            return this._year;
        }// end function

        public function get hasCheckedinToday() : Boolean
        {
            return this._hasCheckedinToday;
        }// end function

        public function get firstDayIndex() : int
        {
            return this._firstDayIndex;
        }// end function

        public function get date() : int
        {
            return this._date;
        }// end function

        public function get daysOfCurrentMonth() : uint
        {
            return this._daysOfCurrentMonth;
        }// end function

        public function get beginDate() : int
        {
            return this._beginDate;
        }// end function

    }
}
