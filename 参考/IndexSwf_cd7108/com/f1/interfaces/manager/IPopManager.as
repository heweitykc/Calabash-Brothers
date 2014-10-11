package com.f1.interfaces.manager
{
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.interfaces.ui.box.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.utils.cue.*;
    import flash.display.*;

    public interface IPopManager
    {

        public function IPopManager();

        function addPop(param1:IBaseBox, param2:Boolean = false, param3:Boolean = false, param4:Boolean = true, param5:Boolean = true, param6:Boolean = false, param7:Boolean = false, param8:LayoutInfo = null, param9:Number = 0.5) : void;

        function addDargLoayer(param1) : void;

        function addedFightTips(param1:DisplayObject, param2:String) : void;

        function flyBossHomeIcon(param1:int, param2:int) : void;

        function cue(param1:String = "", param2:String = null, param3:Array = null, param4:Function = null, param5:Function = null, param6:uint = 2, param7 = null, param8:Boolean = false, param9:Boolean = false, param10:Function = null, param11:Boolean = true) : BaseBox;

        function delBox(param1) : void;

        function addBgMask(param1:Boolean = false, param2:Boolean = false) : void;

        function addedChangeJobEffect(param1:DisplayObject) : void;

        function addedPKTips(param1:DisplayObject) : void;

        function addedServerToCue(param1:ServerHitIcon) : void;

        function addedServerToCueCount(param1:ServerHitIcon, param2:int) : void;

        function addedToMouseCue(param1:String) : void;

        function getServerToCue(param1:String) : ServerHitIcon;

        function addedToSystem(param1:String) : void;

        function addedToFight(param1:String) : void;

        function addedToMarQueeTop(param1:String) : void;

        function addedToStatus(param1:String) : void;

        function addGuideDisplayObject(param1:DisplayObject) : void;

        function showLoadingBox(param1:Boolean = false, param2:uint = 0, param3:Number = 0) : Function;

        function get loadingBox() : UILoadingBox;

        function removeServerToCue(param1:ServerHitIcon) : void;

        function txtCue(param1:String, param2:Number = 2) : void;

        function get txtLayer() : BaseSprite;

        function addedMapNameTips(param1:DisplayObject) : void;

        function closeLoadingBox() : void;

        function hideAllBox() : void;

        function removeBgMask() : void;

        function get cueMaskLayer() : BaseSprite;

        function get marqueeRomor() : IMarquee;

        function addToMainScreen(param1:DisplayObject, param2:LayoutInfo) : void;

        function get marquee() : IMarquee;

        function set marquee(param1:IMarquee) : void;

        function set marqueeRomor(param1:IMarquee) : void;

        function get scrollSystemCue() : ScrollSystemCue;

        function returnScrollSystemBack() : void;

        function addUI(param1:BaseSprite, param2:LayoutInfo = null, param3:uint = 0, param4:Boolean = false) : void;

        function removeUI(param1:BaseSprite) : void;

        function addTips(param1:DisplayObject, param2:LayoutInfo) : void;

        function removeTips(param1:DisplayObject) : void;

    }
}
