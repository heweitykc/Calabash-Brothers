package com.f1.utils.path
{
    import flash.utils.*;

    public class AStar extends Object
    {
        private const COST_STRAIGHT:int = 10;
        private const COST_DIAGONAL:int = 14;
        private const NOTE_ID:int = 0;
        private const NOTE_OPEN:int = 1;
        private const NOTE_CLOSED:int = 2;
        protected var _tiles:ByteArray;
        private var _tw:int;
        private var m_maxTry:uint = 1000;
        private var m_openList:Array;
        private var m_openCount:int;
        private var m_openId:int;
        private var m_xList:Array;
        private var m_yList:Array;
        private var m_pathScoreList:Array;
        private var m_movementCostList:Array;
        private var m_fatherList:Array;
        private var m_noteMap:Array;
        private static const aroundArr:Array = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [-1, -1], [1, -1]];

        public function AStar()
        {
            return;
        }// end function

        public function get tiles() : ByteArray
        {
            return this._tiles;
        }// end function

        public function set tiles(param1:ByteArray) : void
        {
            this._tiles = param1;
            param1.position = 0;
            this._tw = param1.readUnsignedInt();
            return;
        }// end function

        public function get maxTry() : int
        {
            return this.m_maxTry;
        }// end function

        public function set maxTry(param1:int) : void
        {
            this.m_maxTry = param1;
            return;
        }// end function

        public function find(param1:uint, param2:uint, param3:uint, param4:uint, param5:int = 0) : Array
        {
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_6:* = param1;
            var _loc_7:* = param2;
            var _loc_8:* = param3;
            var _loc_9:* = param4;
            if (param5 == 0)
            {
                param5 = this.m_maxTry;
            }
            this.initLists();
            this.m_openCount = 0;
            this.m_openId = -1;
            this.openNote(_loc_6, _loc_7, 0, 0, 0);
            var _loc_10:* = 0;
            while (this.m_openCount > 0)
            {
                
                if (++_loc_10 > param5)
                {
                    this.destroyLists();
                    return null;
                }
                _loc_11 = this.m_openList[0];
                this.closeNote(_loc_11);
                _loc_12 = this.m_xList[_loc_11];
                _loc_13 = this.m_yList[_loc_11];
                if (_loc_12 == _loc_8 && _loc_13 == _loc_9)
                {
                    return this.getPath(param1, param2, param3, param4, _loc_11);
                }
                _loc_14 = this.getArounds(_loc_12, _loc_13);
                for each (_loc_18 in _loc_14)
                {
                    
                    _loc_16 = this.m_movementCostList[_loc_11] + (_loc_18[0] == _loc_12 || _loc_18[1] == _loc_13 ? (this.COST_STRAIGHT) : (this.COST_DIAGONAL));
                    _loc_17 = _loc_16 + (Math.abs(_loc_8 - _loc_18[0]) + Math.abs(_loc_9 - _loc_18[1])) * this.COST_STRAIGHT;
                    if (this.isOpen(_loc_18[0], _loc_18[1]))
                    {
                        _loc_15 = this.m_noteMap[_loc_18[1]][_loc_18[0]][this.NOTE_ID];
                        if (_loc_16 < this.m_movementCostList[_loc_15])
                        {
                            this.m_movementCostList[_loc_15] = _loc_16;
                            this.m_pathScoreList[_loc_15] = _loc_17;
                            this.m_fatherList[_loc_15] = _loc_11;
                            this.aheadNote(this.getIndex(_loc_15));
                        }
                        continue;
                    }
                    this.openNote(_loc_18[0], _loc_18[1], _loc_17, _loc_16, _loc_11);
                }
            }
            this.destroyLists();
            return null;
        }// end function

        private function openNote(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            var _loc_6:* = this;
            var _loc_7:* = this.m_openCount + 1;
            _loc_6.m_openCount = _loc_7;
            var _loc_6:* = this;
            var _loc_7:* = this.m_openId + 1;
            _loc_6.m_openId = _loc_7;
            if (this.m_noteMap[param2] == null)
            {
                this.m_noteMap[param2] = [];
            }
            this.m_noteMap[param2][param1] = [];
            this.m_noteMap[param2][param1][this.NOTE_OPEN] = true;
            this.m_noteMap[param2][param1][this.NOTE_ID] = this.m_openId;
            this.m_xList.push(param1);
            this.m_yList.push(param2);
            this.m_pathScoreList.push(param3);
            this.m_movementCostList.push(param4);
            this.m_fatherList.push(param5);
            this.m_openList.push(this.m_openId);
            this.aheadNote(this.m_openCount);
            return;
        }// end function

        private function closeNote(param1:int) : void
        {
            var _loc_4:* = this;
            var _loc_5:* = this.m_openCount - 1;
            _loc_4.m_openCount = _loc_5;
            var _loc_2:* = this.m_xList[param1];
            var _loc_3:* = this.m_yList[param1];
            this.m_noteMap[_loc_3][_loc_2][this.NOTE_OPEN] = false;
            this.m_noteMap[_loc_3][_loc_2][this.NOTE_CLOSED] = true;
            if (this.m_openCount <= 0)
            {
                this.m_openCount = 0;
                this.m_openList = [];
                return;
            }
            this.m_openList[0] = this.m_openList.pop();
            this.backNote();
            return;
        }// end function

        private function aheadNote(param1:int) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            while (param1 > 1)
            {
                
                _loc_2 = Math.floor(param1 / 2);
                if (this.getScore(param1) < this.getScore(_loc_2))
                {
                    _loc_3 = this.m_openList[(param1 - 1)];
                    this.m_openList[(param1 - 1)] = this.m_openList[(_loc_2 - 1)];
                    this.m_openList[(_loc_2 - 1)] = _loc_3;
                    param1 = _loc_2;
                    continue;
                }
                break;
            }
            return;
        }// end function

        private function backNote() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_1:* = 1;
            while (true)
            {
                
                _loc_2 = _loc_1;
                if (2 * _loc_2 <= this.m_openCount)
                {
                    if (this.getScore(_loc_1) > this.getScore(2 * _loc_2))
                    {
                        _loc_1 = 2 * _loc_2;
                    }
                    if (2 * _loc_2 + 1 <= this.m_openCount)
                    {
                        if (this.getScore(_loc_1) > this.getScore(2 * _loc_2 + 1))
                        {
                            _loc_1 = 2 * _loc_2 + 1;
                        }
                    }
                }
                if (_loc_2 == _loc_1)
                {
                    break;
                    continue;
                }
                _loc_3 = this.m_openList[(_loc_2 - 1)];
                this.m_openList[(_loc_2 - 1)] = this.m_openList[(_loc_1 - 1)];
                this.m_openList[(_loc_1 - 1)] = _loc_3;
            }
            return;
        }// end function

        private function isOpen(param1:int, param2:int) : Boolean
        {
            if (this.m_noteMap[param2] == null)
            {
                return false;
            }
            if (this.m_noteMap[param2][param1] == null)
            {
                return false;
            }
            return this.m_noteMap[param2][param1][this.NOTE_OPEN];
        }// end function

        private function isClosed(param1:int, param2:int) : Boolean
        {
            if (this.m_noteMap[param2] == null)
            {
                return false;
            }
            if (this.m_noteMap[param2][param1] == null)
            {
                return false;
            }
            return this.m_noteMap[param2][param1][this.NOTE_CLOSED];
        }// end function

        protected function canPass(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = 0;
            if (this._tiles)
            {
                _loc_3 = this._tw * param2 + param1 + 8;
                if (this._tiles.length > _loc_3)
                {
                    this._tiles.position = _loc_3;
                    return this._tiles.readByte();
                }
            }
            return 1;
        }// end function

        private function getArounds(param1:int, param2:int) : Array
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_10:* = null;
            var _loc_3:* = 1;
            var _loc_4:* = 8;
            var _loc_8:* = [];
            var _loc_9:* = [];
            for each (_loc_10 in aroundArr)
            {
                
                _loc_6 = param1 + _loc_10[0];
                _loc_7 = param2 + _loc_10[1];
                _loc_5 = this.canPass(_loc_6, _loc_7);
                if ((_loc_5 & _loc_3) == 0 && !this.isClosed(_loc_6, _loc_7))
                {
                    _loc_8.push([_loc_6, _loc_7]);
                }
            }
            return _loc_8;
        }// end function

        protected function getPath(param1:int, param2:int, param3:int, param4:int, param5:int) : Array
        {
            var _loc_12:* = null;
            var _loc_6:* = [];
            var _loc_7:* = this.m_xList[param5];
            var _loc_8:* = this.m_yList[param5];
            var _loc_9:* = param1;
            var _loc_10:* = param2;
            var _loc_11:* = [param3, param4];
            while (_loc_7 != _loc_9 || _loc_8 != _loc_10)
            {
                
                _loc_12 = [param1 + (_loc_7 - _loc_9), param2 + (_loc_8 - _loc_10)];
                _loc_11 = _loc_12;
                _loc_6.unshift(_loc_12);
                param5 = this.m_fatherList[param5];
                _loc_7 = this.m_xList[param5];
                _loc_8 = this.m_yList[param5];
            }
            _loc_6.unshift([param1, param2]);
            this.destroyLists();
            return _loc_6;
        }// end function

        private function getIndex(param1:int) : int
        {
            var _loc_3:* = 0;
            var _loc_2:* = 1;
            for each (_loc_3 in this.m_openList)
            {
                
                if (_loc_3 == param1)
                {
                    return _loc_2;
                }
                _loc_2++;
            }
            return -1;
        }// end function

        private function getScore(param1:int) : int
        {
            return this.m_pathScoreList[this.m_openList[(param1 - 1)]];
        }// end function

        private function initLists() : void
        {
            this.m_openList = [];
            this.m_xList = [];
            this.m_yList = [];
            this.m_pathScoreList = [];
            this.m_movementCostList = [];
            this.m_fatherList = [];
            this.m_noteMap = [];
            return;
        }// end function

        private function destroyLists() : void
        {
            this._tiles = null;
            this.m_openList = null;
            this.m_xList = null;
            this.m_yList = null;
            this.m_pathScoreList = null;
            this.m_movementCostList = null;
            this.m_fatherList = null;
            this.m_noteMap = null;
            return;
        }// end function

    }
}
