package com.game.newactivity.rechargedays.model
{
    import com.model.vo.*;

    public class RechargeDaysInfo extends Object
    {
        private var _props:Array;
        private var _canGet:int;
        private var _groupProp:PropInfo;
        private var _curGroups:int;
        private var _canGetGroup:int;
        private var _needGroups:int;
        private var _key:String;
        private var _index:int;
        private var _groupIndex:int;

        public function RechargeDaysInfo()
        {
            return;
        }// end function

        public function get canGetGroup() : int
        {
            return this._canGetGroup;
        }// end function

        public function set canGetGroup(param1:int) : void
        {
            this._canGetGroup = param1;
            return;
        }// end function

        public function get groupIndex() : int
        {
            return this._groupIndex;
        }// end function

        public function set groupIndex(param1:int) : void
        {
            this._groupIndex = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get props() : Array
        {
            return this._props;
        }// end function

        public function set props(param1:Array) : void
        {
            this._props = param1;
            return;
        }// end function

        public function get canGet() : int
        {
            return this._canGet;
        }// end function

        public function set canGet(param1:int) : void
        {
            this._canGet = param1;
            return;
        }// end function

        public function get groupProp() : PropInfo
        {
            return this._groupProp;
        }// end function

        public function set groupProp(param1:PropInfo) : void
        {
            this._groupProp = param1;
            return;
        }// end function

        public function get curGroups() : int
        {
            return this._curGroups;
        }// end function

        public function set curGroups(param1:int) : void
        {
            this._curGroups = param1;
            return;
        }// end function

        public function get needGroups() : int
        {
            return this._needGroups;
        }// end function

        public function set needGroups(param1:int) : void
        {
            this._needGroups = param1;
            return;
        }// end function

        public function get key() : String
        {
            return this._key;
        }// end function

        public function set key(param1:String) : void
        {
            this._key = param1;
            return;
        }// end function

        public function get isCanGetGroup() : Boolean
        {
            return this._needGroups >= this._curGroups;
        }// end function

        public function get judge() : Boolean
        {
            return true;
        }// end function

    }
}
