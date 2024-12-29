-- CreateEnum
CREATE TYPE "HeroStatus" AS ENUM ('incomplete', 'knocked_out', 'completed');

-- CreateEnum
CREATE TYPE "RunStatus" AS ENUM ('in_progress', 'complete');

-- CreateEnum
CREATE TYPE "OverwatchHeroRole" AS ENUM ('tank', 'damage', 'support');

-- CreateTable
CREATE TABLE "OverwatchHero" (
    "name" TEXT NOT NULL,
    "role" "OverwatchHeroRole" NOT NULL,

    CONSTRAINT "OverwatchHero_pkey" PRIMARY KEY ("name")
);

-- CreateTable
CREATE TABLE "NuzlockeRun" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "status" "RunStatus" NOT NULL,
    "runnerId" INTEGER NOT NULL,

    CONSTRAINT "NuzlockeRun_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "NuzlockeRunHeroStatus" (
    "runId" INTEGER NOT NULL,
    "heroName" TEXT NOT NULL,
    "status" "HeroStatus" NOT NULL
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "NuzlockeRunHeroStatus_runId_heroName_key" ON "NuzlockeRunHeroStatus"("runId", "heroName");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- AddForeignKey
ALTER TABLE "NuzlockeRun" ADD CONSTRAINT "NuzlockeRun_runnerId_fkey" FOREIGN KEY ("runnerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NuzlockeRunHeroStatus" ADD CONSTRAINT "NuzlockeRunHeroStatus_runId_fkey" FOREIGN KEY ("runId") REFERENCES "NuzlockeRun"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NuzlockeRunHeroStatus" ADD CONSTRAINT "NuzlockeRunHeroStatus_heroName_fkey" FOREIGN KEY ("heroName") REFERENCES "OverwatchHero"("name") ON DELETE RESTRICT ON UPDATE CASCADE;
