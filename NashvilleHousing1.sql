select SaleDateConverted, CONVERT(date,SaleDate)
from PortfolioProject.dbo.Nashville_Housing
order by SaleDate asc

UPDATE
Nashville_Housing 
set SaleDate = CONVERT(date,SaleDate,102)

select SaleDate
from PortfolioProject.dbo.Nashville_Housing
order by SaleDate asc

Alter Table Nashville_Housing
add SaleDateConverted Date;

UPDATE
Nashville_Housing 
set SaleDateConverted = CONVERT(date,SaleDate)


--Populate Property Adress Data

Select *
from PortfolioProject.dbo.Nashville_Housing
--where PropertyAddress is NULL
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)  
from PortfolioProject.dbo.Nashville_Housing a
JOIN PortfolioProject.dbo.Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.Nashville_Housing a
JOIN PortfolioProject.dbo.Nashville_Housing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is NULL

Select PropertyAddress
from PortfolioProject.dbo.Nashville_Housing
--where PropertyAddress is NULL
--order by ParcelID


--Breaking out Adress into individual columns

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as Address
from PortfolioProject.dbo.Nashville_Housing

Alter Table Nashville_Housing
add PropertyAddressSplit Nvarchar(255);

UPDATE
Nashville_Housing 
set PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

Alter Table Nashville_Housing
add PropertyAddressCity Nvarchar(255);

UPDATE
Nashville_Housing 
set PropertyAddressCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress))

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from PortfolioProject.dbo.Nashville_Housing

Alter Table Nashville_Housing
add OwnerSplitAddress Nvarchar(255);

UPDATE
Nashville_Housing 
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


Alter Table Nashville_Housing
add OwnerSplitCity Nvarchar(255);

UPDATE
Nashville_Housing 
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

Alter Table Nashville_Housing
add OwnerSplitState Nvarchar(255);

UPDATE
Nashville_Housing 
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

select Distinct SoldAsVacant, count(SoldAsVacant)
from PortfolioProject..Nashville_Housing
group by SoldAsVacant
order by 1

Select SoldAsVacant,
CASE When SoldAsVacant = 'Y' THEN 'Yes'
	 When SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
from PortfolioProject..Nashville_Housing


UPDATE
Nashville_Housing 
set SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	 When SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END

--Remove Duplicates

select *
from PortfolioProject..Nashville_Housing

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				LegalReference
				Order by
					UniqueID
					) row_num
from PortfolioProject..Nashville_Housing
)
Select *
From RowNumCTE
where row_num >1
order by PropertyAddress


--delete unused columns

ALTER TABLE PortfolioProject.dbo.Nashville_Housing
DROP COLUMN  SaleDate

select* 
from PortfolioProject..Nashville_Housing

