package com.game.greedisland.view
{
    import com.cfg.obj.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.path.*;
    import com.game.role.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class IslandBoxTips extends BaseBox
    {
        private var closeBtn:BaseButton;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var _clientMonster:Role;
        private var goodsId:Array;

        public function IslandBoxTips()
        {
            this.goodsId = [600001, 600002, 600003, 600004];
            loadDisplay("res/islandcopyinfo.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("monsterTips");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.goodsId = GlobalCfgObj.getInstance().getCfgById("279").q_string_value.split(";");
            var _loc_1:* = 0;
            while (_loc_1 < 4)
            {
                
                _loc_2 = new IconItem("commonRewardBox2_40");
                _loc_3 = PropUtil.createItemByCfg(this.goodsId[_loc_1]);
                _loc_2.image.move(4, 3);
                _loc_2.setWH(46, 46);
                _loc_2.setInfo(_loc_3);
                this["mc" + (_loc_1 + 1)] = getDisplayChildByName("img" + (_loc_1 + 1));
                this["mc" + (_loc_1 + 1)].addChild(_loc_2);
                _loc_1++;
            }
            if (this._clientMonster == null)
            {
                this._clientMonster = new Role();
                _loc_4 = new RoleInfo();
                _loc_4.personId = long.fromNumber(888);
                var _loc_5:* = 70;
                _loc_4.x = 70;
                this._clientMonster.x = _loc_5;
                var _loc_5:* = 175;
                _loc_4.y = 175;
                this._clientMonster.y = _loc_5;
                _loc_4.url = Params.ROLE_RES_PATH + GlobalCfgObj.getInstance().getCfgById("278").q_string_value;
                this._clientMonster.info = _loc_4;
                this._clientMonster.direct = MapUtils.mapDirect2RoleDir(3);
                this._clientMonster.setAct("act05", true);
                this._clientMonster.auto = true;
                this._clientMonster.mouseChildren = false;
                this._clientMonster.mouseEnabled = false;
                this.addChild(this._clientMonster);
            }
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 10, 10);
            this.update();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            return;
        }// end function

        private function update() : void
        {
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.update();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
