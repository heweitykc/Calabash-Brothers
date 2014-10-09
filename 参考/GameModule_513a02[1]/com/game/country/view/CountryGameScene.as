package com.game.country.view
{
    import com.f1.utils.path.*;
    import com.f1.vmc.*;
    import com.game.country.control.*;
    import com.game.map.control.*;
    import com.game.map.model.*;
    import com.game.map.view.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.events.*;

    public class CountryGameScene extends GameScene
    {
        private var _control:CountryControl;
        private var _monster1:int = 888;
        private var _monster2:int = 889;
        private var _monster3:int = 890;
        private var _monster4:int = 891;
        private var _clientMonst1:Role;
        private var _clientMonst2:Role;
        private var _clientMonst3:Role;
        private var _clientMonst4:Role;
        private var _gap_1:Array;
        private var _gap_2:Array;
        private var _gap_3:Array;
        private var _gap_4:Array;
        private var _gate1:Array;
        private var _gate2:Array;
        private var _gate3:Array;
        private var _gate4:Array;
        private var lastState:int = -1;
        private var effect1:VMCView;
        private var effect2:VMCView;
        private var effect3:VMCView;

        public function CountryGameScene()
        {
            this._gap_1 = [{tx:186, ty:226}, {tx:187, ty:226}, {tx:186, ty:227}, {tx:187, ty:227}, {tx:187, ty:227}, {tx:188, ty:227}, {tx:186, ty:228}, {tx:187, ty:228}, {tx:187, ty:228}, {tx:188, ty:228}, {tx:189, ty:228}, {tx:187, ty:229}, {tx:188, ty:229}, {tx:189, ty:229}, {tx:190, ty:229}, {tx:191, ty:229}, {tx:192, ty:229}, {tx:188, ty:230}, {tx:189, ty:230}, {tx:190, ty:230}, {tx:191, ty:230}, {tx:192, ty:230}, {tx:189, ty:231}, {tx:190, ty:231}, {tx:191, ty:231}, {tx:192, ty:231}, {tx:193, ty:231}, {tx:191, ty:232}, {tx:192, ty:232}, {tx:193, ty:232}];
            this._gap_2 = [{tx:305, ty:167}, {tx:306, ty:167}, {tx:305, ty:168}, {tx:306, ty:168}, {tx:307, ty:168}, {tx:308, ty:168}, {tx:305, ty:169}, {tx:306, ty:169}, {tx:307, ty:169}, {tx:308, ty:169}, {tx:309, ty:169}, {tx:305, ty:170}, {tx:306, ty:170}, {tx:307, ty:170}, {tx:308, ty:170}, {tx:309, ty:170}, {tx:310, ty:170}, {tx:311, ty:170}, {tx:312, ty:170}, {tx:308, ty:171}, {tx:309, ty:171}, {tx:310, ty:171}, {tx:311, ty:171}, {tx:312, ty:171}, {tx:309, ty:172}, {tx:310, ty:172}, {tx:311, ty:172}, {tx:312, ty:172}, {tx:313, ty:172}, {tx:311, ty:173}, {tx:312, ty:173}, {tx:313, ty:173}];
            this._gap_3 = [{tx:407, ty:115}, {tx:408, ty:115}, {tx:409, ty:115}, {tx:407, ty:116}, {tx:408, ty:116}, {tx:409, ty:116}, {tx:410, ty:116}, {tx:411, ty:116}, {tx:407, ty:117}, {tx:408, ty:117}, {tx:409, ty:117}, {tx:410, ty:117}, {tx:411, ty:117}, {tx:412, ty:117}, {tx:408, ty:118}, {tx:409, ty:118}, {tx:410, ty:118}, {tx:411, ty:118}, {tx:412, ty:118}, {tx:413, ty:118}, {tx:414, ty:118}, {tx:415, ty:118}, {tx:411, ty:119}, {tx:412, ty:119}, {tx:413, ty:119}, {tx:414, ty:119}, {tx:415, ty:119}, {tx:412, ty:120}, {tx:413, ty:120}, {tx:414, ty:120}, {tx:415, ty:120}, {tx:416, ty:120}, {tx:414, ty:121}, {tx:415, ty:121}, {tx:416, ty:121}];
            this._gap_4 = [];
            this._gate1 = [188, 227];
            this._gate2 = [307, 168];
            this._gate3 = [411, 117];
            this._gate4 = [521, 62];
            this._control = CountryControl.getInstance();
            this._control.scene = this;
            return;
        }// end function

        override public function changeMap() : void
        {
            super.changeMap();
            return;
        }// end function

        public function updateBlock(param1:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < 4)
            {
                
                if (param1[_loc_2] == 0)
                {
                    MapObj.getInstance().generateObstacle(this["_gap_" + (_loc_2 + 1)], false);
                }
                else
                {
                    MapObj.getInstance().generateObstacle(this["_gap_" + (_loc_2 + 1)]);
                    if (param1[_loc_2] == 2)
                    {
                        if (this["_clientMonst" + (_loc_2 + 1)] == null)
                        {
                            this["_clientMonst" + (_loc_2 + 1)] = new Role();
                            _loc_3 = MapUtils.tile2Coo(this["_gate" + (_loc_2 + 1)]);
                            _loc_4 = new RoleInfo();
                            _loc_4.personId = long.fromNumber(this["_monster" + (_loc_2 + 1)]);
                            var _loc_5:* = _loc_3[0];
                            _loc_4.x = _loc_3[0];
                            this["_clientMonst" + (_loc_2 + 1)].x = _loc_5;
                            var _loc_5:* = _loc_3[1];
                            _loc_4.y = _loc_3[1];
                            this["_clientMonst" + (_loc_2 + 1)].y = _loc_5;
                            _loc_4.speed = 0;
                            if (_loc_2 == 3)
                            {
                                _loc_4.url = Params.ROLE_RES_PATH + "ms138";
                            }
                            else
                            {
                                _loc_4.url = Params.ROLE_RES_PATH + "ms140";
                            }
                            this["_clientMonst" + (_loc_2 + 1)].direct = MapUtils.mapDirect2RoleDir(2);
                            this["_clientMonst" + (_loc_2 + 1)].info = _loc_4;
                            this["_clientMonst" + (_loc_2 + 1)].visible = true;
                            if (_loc_2 == 3)
                            {
                            }
                            else
                            {
                                MapControl.getInstance().addSpeciaRole(this["_clientMonst" + (_loc_2 + 1)]);
                            }
                        }
                    }
                    else if (this["_clientMonst" + (_loc_2 + 1)] != null)
                    {
                        MapControl.getInstance().removeRoleFromMap(this["_clientMonst" + (_loc_2 + 1)]);
                        this["_clientMonst" + (_loc_2 + 1)].finalize();
                        this["_clientMonst" + (_loc_2 + 1)] = null;
                    }
                }
                _loc_2++;
            }
            if (param1[3] == 2 && this.lastState != 2)
            {
                this.__playAppearEffect();
            }
            if (param1[3] == 1 && this.lastState != 1)
            {
                this.__playDisAppearEffect();
            }
            this.lastState = param1[3];
            return;
        }// end function

        public function __playAppearEffect() : void
        {
            if (this.effect1 == null)
            {
                this.effect1 = new VMCView();
                this.effect1.auto = true;
            }
            this.effect1.loadRes("res/effect/country/stateAppear.png");
            this.effect1.updatePose("90", false, false, true);
            this.effect1.replay();
            var _loc_1:* = MapUtils.tile2Coo(this._gate4);
            this.effect1.move(_loc_1[0], _loc_1[1]);
            MapControl.getInstance().addCountryDisplay(this.effect1);
            this.effect1.addEvtListener(Event.COMPLETE, this.__playNormalEffect);
            return;
        }// end function

        public function __playDisAppearEffect() : void
        {
            if (this.effect3 && this.effect3.parent)
            {
                this.effect3.removeFromParent();
            }
            if (this.effect2 == null)
            {
                this.effect2 = new VMCView();
                this.effect2.auto = true;
            }
            this.effect2.loadRes("res/effect/country/stateDisAppear.png");
            this.effect2.updatePose("90", false, false, true);
            this.effect2.replay();
            var _loc_1:* = MapUtils.tile2Coo(this._gate4);
            this.effect2.move(_loc_1[0], _loc_1[1]);
            MapControl.getInstance().addCountryDisplay(this.effect2);
            return;
        }// end function

        public function __playNormalEffect(event:Event) : void
        {
            if (this.effect3 == null)
            {
                this.effect3 = new VMCView();
                this.effect3.auto = true;
            }
            this.effect3.loadRes("res/effect/country/stateNormal.png");
            this.effect3.updatePose("90", true);
            this.effect3.replay();
            var _loc_2:* = MapUtils.tile2Coo(this._gate4);
            this.effect3.move(_loc_2[0], _loc_2[1]);
            MapControl.getInstance().addCountryDisplay(this.effect3);
            return;
        }// end function

        override public function finalize() : void
        {
            if (_playerRole)
            {
                (_playerRole as Role).removeCountryTitle();
                (_playerRole as Role).showTitle();
            }
            super.finalize();
            CountryControl.getInstance().out();
            return;
        }// end function

    }
}
