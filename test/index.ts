import { expect } from "chai";
import { upgrades, ethers } from "hardhat";

describe("ContractVersions", function () {
  it("Should call initialize function on upgrade", async function () {
    const param1 = 100;
    const param2 = 200;
    const param3 = 300;
    const param4 = 400;

    const Example0 = await ethers.getContractFactory("Example_v0");
    let example = await upgrades.deployProxy(Example0, [param1, param2], {
      kind: "uups",
    });
    await example.deployed();

    expect(await example.getSum()).to.equal(param1 + param2);
    expect(await example.contractVersion()).to.equal(0); // version = 0

    const Example1 = await ethers.getContractFactory("Example_v1");
    example = await upgrades.upgradeProxy(example.address, Example1, {
      call: { fn: "initialize_v1", args: [param3, param4] },
    });
    expect(await example.getSum()).to.equal(param1 + param2 + param3 + param4);
    expect(await example.contractVersion()).to.equal(1); // version = 1

    // external call to `initialize_v1` after upgrade
    const param5 = 3000;
    const param6 = 4000;
    await expect(example.initialize_v1(param5, param6)).to.be.revertedWith(
      "wrong base version"
    );
  });
});
