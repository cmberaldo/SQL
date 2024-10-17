-- SQL Server Version
-- Automatically creates a pattern of numbers starting at the first position and ending at the center, 
-- passing only the number of rows and columns. Ex: 8 = will create an 8x8 pattern
-- NOTE: limit will be 99 (maximum size of a string) 

alter PROCEDURE sp_print_pattern_v2(@n INT = 5) AS
BEGIN

DECLARE @pattern VARCHAR(MAX) = ''
DECLARE @pattern2 VARCHAR(2000) = ''
DECLARE @lencha VARCHAR(10) = ''
DECLARE @item VARCHAR(5) = ''
DECLARE @line INT = 0
DECLARE @posini INT = 1
DECLARE @posend INT = 1
DECLARE @i INT = 1
DECLARE @j INT = 0
DECLARE @k INT = 0
DECLARE @counter INT = 0
DECLARE @posstr INT = 0


if len(trim(str(@n*@n))) = 1
	SET @lencha = ' X'
else if len(trim(str(@n*@n))) = 2
	SET @lencha = ' XX'
else if len(trim(str(@n*@n))) = 3
		SET @lencha = ' XXX'
else if len(trim(str(@n*@n))) = 4
	SET @lencha = ' XXXX'
else
	SET @lencha = ' XXXXX'

SET @posend = (@n*@n) * len(@lencha)

SET @line = @n * len(@lencha)

-- Create a fake matrix with VARCHAR
While @posini < @posend
	BEGIN

	SET @pattern = @pattern + @lencha
	SET @posini = @posini + len(@lencha)

	END


while @counter < (@n*@n)
	BEGIN

	while @j < @n-@k
		BEGIN
		SET @j += 1
		SET @counter += 1
		
		if @posstr > 0
			SET @posstr = ((((@i - 1) * @n) + (@j-1)) * len(@lencha)) +1
		else
			SET @posstr = (((@i - 1) * @n) + @j)

		SET @item = ' ' + Replicate('0',(len(@lencha) - len(trim(str(@counter))) - 1)) + trim(str(@counter))
		
		if @posstr > 1
			SET @pattern = substring(@pattern,1,(@posstr - 1)) + @item + substring(@pattern, (@posstr+len(@lencha)) ,(len(@pattern) - len(substring(@pattern,1,(@posstr - 1)) + @item)))
		else
			SET @pattern = @item + substring(@pattern,(@posstr+len(@item)), len(@pattern)-len(@item))

		--print(trim(str(@i))+'/'+trim(str(@j))+'--'+trim(str(@counter))+'--'+trim(str(@posstr))+'--'+trim(@item)+'--'+trim(str(len(@lencha))))
		
		END
		
	while @i < @n-@k
		BEGIN
		SET @counter += 1
		SET @i +=1
		if @posstr > 1
			SET @posstr = ((((@i - 1) * @n) + (@j-1)) * len(@lencha)) +1
		else
			SET @posstr = (((@i - 1) * @n) + @j)
		
		SET @item = ' ' + Replicate('0',(len(@lencha) - len(trim(str(@counter))) - 1)) + trim(str(@counter))

		if @posstr > 1
			SET @pattern = substring(@pattern,1,(@posstr - 1)) + @item + substring(@pattern, (@posstr+len(@lencha)) ,(len(@pattern) - len(substring(@pattern,1,(@posstr - 1)) + @item)))
		else
			SET @pattern = @item + substring(@pattern,(@posstr+len(@lencha)), len(@pattern)-len(@item))
		
		
		--print(trim(str(@i))+'/'+trim(str(@j))+'--'+trim(str(@counter))+'--'+trim(str(@posstr))+'--'+trim(@item)+'--'+trim(str(len(@lencha))))

		END
		
	while @j > @k+1
		BEGIN
		SET @counter += 1
		SET @j -=1
		SET @posstr = (((@i - 1) * @n) + (@j-1)) 
		if @posstr > 1
			SET @posstr = ((((@i - 1) * @n) + (@j-1)) * len(@lencha)) +1
		else
			SET @posstr = (((@i - 1) * @n) + @j)
			
		SET @item = ' ' + Replicate('0',(len(@lencha) - len(trim(str(@counter))) - 1)) + trim(str(@counter))

		if @posstr > 1
			SET @pattern = substring(@pattern,1,(@posstr - 1)) + @item + substring(@pattern, (@posstr+len(@lencha)) ,(len(@pattern) - len(substring(@pattern,1,(@posstr - 1)) + @item)))
		else
			SET @pattern = @item + substring(@pattern,(@posstr+len(@lencha)), len(@pattern)-len(@item))

		--print(trim(str(@i))+'/'+trim(str(@j))+'--'+trim(str(@counter))+'--'+trim(str(@posstr))+'--'+trim(@item)+'--'+trim(str(len(@lencha))))

		END
		
	while @i > @k +2
		BEGIN
		SET @counter += 1
		SET @i -=1
		SET @posstr = (((@i - 1) * @n) + (@j-1)) 
		if @posstr > 1
			SET @posstr = ((((@i - 1) * @n) + (@j-1)) * len(@lencha)) +1
		else
			SET @posstr = (((@i - 1) * @n) + @j)

		SET @item = ' ' + Replicate('0',(len(@lencha) - len(trim(str(@counter))) - 1)) + trim(str(@counter))

		if @posstr > 1
			SET @pattern = substring(@pattern,1,(@posstr - 1)) + @item + substring(@pattern, (@posstr+len(@item)) ,(len(@pattern) - len(substring(@pattern,1,(@posstr - 1)) + @item)))
		else
			SET @pattern = @item + substring(@pattern,(@posstr+len(@item)), len(@pattern)-len(@item))


		--print(trim(str(@i))+'/'+trim(str(@j))+'--'+trim(str(@counter))+'--'+trim(str(@posstr))+'--'+trim(@item)+'--'+trim(str(len(@lencha))))
		
		END
		
	SET @k += 1
	END

-- Initialize initial position
	SET @posini = 1

-- Print Matrix
While @posini < @posend
	BEGIN

	SET @pattern2 = substring(@pattern,@posini, @line)
	SET @posini = @posini + @line
	print(@pattern2)

	END
	
END


exec sp_print_pattern_v2 10