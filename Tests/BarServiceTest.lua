
BarServiceTest = _G.unittest();

function BarServiceTest:Constructor()
    Turbine.Shell.WriteLine("BarServiceTest:Constructor");
end

function BarServiceTest:Setup()
    Turbine.Shell.WriteLine("Test Setup");
end

function BarServiceTest:TestBar()
    Turbine.Shell.WriteLine("TestBar");
    Assert.IsTrue(true, "haha");
end