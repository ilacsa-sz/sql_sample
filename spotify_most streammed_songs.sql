--1. Is there any NULL values in the dataset?

WITH datacounts AS (
SELECT COUNT(*) AS all_records,
		COUNT(track_name) AS count_all_tracks,
		COUNT(artists_name) AS count_all_names,
		COUNT(artist_count) AS count_all_artists_count,
		COUNT(released_year) AS count_all_years,
		COUNT(released_month) AS count_all_months,
		COUNT(released_day) AS count_all_days,
		COUNT(in_spotify_playlists) AS count_all_sf_lists,
		COUNT(in_spotify_charts) AS count_all_sp_charts,
		COUNT(streams) AS count_all_streams,
		COUNT(in_apple_playlists) AS count_all_apple_playlists,	
		COUNT(in_apple_charts) AS count_all_apple_charts,
		COUNT(in_deezer_playlists) AS count_all_deezer_playlists,
		COUNT(in_deezer_charts) AS count_all_deezer_charts,
		COUNT(in_shazam_charts) AS count_all_shazam_charts,
		COUNT(bpm) AS count_all_bpm,
		COUNT(key_musical) AS count_all_key_musical,
		COUNT(mode_musical) AS count_all_modes,
		COUNT(danceability) AS count_all_danceability,
		COUNT(valence) AS count_all_valence,
		COUNT(energy) AS count_all_energy,
		COUNT(acousticness) AS count_all_acousticness,
		COUNT(instrumentalness) AS count_all_instrumentalness,
		COUNT(liveness) AS count_all_liveness,
		COUNT(speechiness) AS count_all_speechiness
FROM most_streamed_songs
)
SELECT all_records - count_all_tracks AS missing_tracks,
		all_records - count_all_names AS missing_names,
		all_records - count_all_artists_count AS missing_artists_count,
		all_records - count_all_years AS missing_years,
		all_records - count_all_months AS missing_month,
		all_records - count_all_days AS missing_days,
		all_records - count_all_sf_lists AS missing_sf_lists,
		all_records - count_all_sp_charts AS missing_sp_charts,
		all_records - count_all_streams AS missing_streams,
		all_records - count_all_apple_playlists AS missing_apple_playlists,
		all_records - count_all_apple_charts AS missing_apple_charts,
		all_records - count_all_deezer_playlists AS missing_deezer_playlists,
		all_records - count_all_deezer_charts AS missing_deezaer_charts,
		all_records - count_all_shazam_charts AS missing_shazam_charts,
		all_records - count_all_bpm AS missing_bpm,
		all_records - count_all_key_musical AS missing_key,
		all_records - count_all_modes AS missing_modes,
		all_records - count_all_danceability AS missing_danceability,
		all_records - count_all_valence AS missing_valence,
		all_records - count_all_energy AS missing_energy,
		all_records - count_all_acousticness AS missing_acousticness,
		all_records - count_all_instrumentalness AS missing_instrumentalness,
		all_records - count_all_liveness AS missing_liveness,
		all_records - count_all_speechiness AS missing_speechiness
FROM datacounts;

--2. Let's create the artists their new table!

--I added a new column (song_id, serial), then I created a new table 'artists' and separated the initial artists_name column into rows using the comma as a separator.
INSERT INTO artists
SELECT
	song_id,
	UNNEST(regexp_split_to_array(artists_name, ', '))
FROM most_streamed_songs;

--3. How many unique values are there among the cathegorical data?

SELECT COUNT(DISTINCT m.track_name) AS count_track_name,
	   COUNT(DISTINCT a.artists_name) AS count_artists_name,
	   COUNT(DISTINCT m.mode_musical) AS count_mode,
	   COUNT(DISTINCT m.key_musical) AS count_key
FROM most_streamed_songs AS m
LEFT JOIN artists AS a
USING(song_id);

-- 4. Which are the minimum and maximum values of the numerical data columns?

CREATE TEMP TABLE minmax AS
SELECT 'artist_count'::varchar AS category,
		MIN(artist_count) AS minimum,
		MAX(artist_count) AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'released_year'::varchar AS category,
		MIN(released_year) AS minimum,
		MAX(released_year)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'released_month'::varchar AS category,
		MIN(released_month) AS minimum,
		MAX(released_month)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'released_day'::varchar AS category,
		MIN(released_day) AS minimum,
		MAX(released_day)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'in_spotify_playlists'::varchar AS category,
		MIN(in_spotify_playlists) AS minimum,
		MAX(in_spotify_playlists)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'in_spotify_charts'::varchar AS category,
		MIN(in_spotify_charts) AS minimum,
		MAX(in_spotify_charts)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'streams'::varchar AS category,
		MIN(streams) AS minimum,
		MAX(streams)/1000000 AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'in_apple_playlists'::varchar AS category,
		MIN(in_apple_playlists) AS minimum,
		MAX(in_apple_playlists)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'in_apple_charts'::varchar AS category,
		MIN(in_apple_charts) AS minimum,
		MAX(in_apple_charts)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'in_deezer_playlists'::varchar AS category,
		MIN(in_deezer_playlists) AS minimum,
		MAX(in_deezer_playlists)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'in_deezer_charts'::varchar AS category,
		MIN(in_deezer_charts) AS minimum,
		MAX(in_deezer_charts)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'in_shazam_charts'::varchar AS category,
		MIN(in_shazam_charts) AS minimum,
		MAX(in_shazam_charts)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'bpm'::varchar AS category,
		MIN(bpm) AS minimum,
		MAX(bpm)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'danceability'::varchar AS category,
		MIN(danceability) AS minimum,
		MAX(danceability)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'valence'::varchar AS category,
		MIN(valence) AS minimum,
		MAX(valence)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'energy'::varchar AS category,
		MIN(energy) AS minimum,
		MAX(energy)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'acousticness'::varchar AS category,
		MIN(acousticness) AS minimum,
		MAX(acousticness)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'instrumentalness'::varchar AS category,
		MIN(instrumentalness) AS minimum,
		MAX(instrumentalness)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'liveness'::varchar AS category,
		MIN(liveness) AS minimum,
		MAX(liveness)AS maximum
FROM most_streamed_songs;

INSERT INTO minmax
SELECT 'speechiness'::varchar AS category,
		MIN(speechiness) AS minimum,
		MAX(speechiness)AS maximum
FROM most_streamed_songs;

SELECT *
FROM minmax;

--5. What is the correlation between the streams and the characteristic attributes?

SELECT CORR(streams, bpm) AS bpm,
		CORR(streams, danceability) AS danceability,
		CORR(streams, valence) AS valence,
		CORR(streams, energy) AS energy,
		CORR(streams, acousticness) AS acusticness,
		CORR(streams, instrumentalness) AS instrumentalness,
		CORR(streams, liveness) AS liveness,
		CORR(streams, speechiness) AS speechiness
FROM most_streamed_songs;

--6. Who are the 10 most streamed artists?

SELECT	RANK() OVER(ORDER BY SUM(m.streams) DESC),
		a.artists_name,
		SUM(m.streams) AS total_streams
FROM most_streamed_songs AS m
LEFT JOIN artists AS a
ON m.song_id = a.song_id
GROUP BY a.artists_name
HAVING SUM(m.streams) > 0
ORDER BY total_streams DESC
LIMIT 10;

--7. Which are the average attributes of the 50 most streamed song?

SELECT	ROUND(AVG(m.bpm), 2) AS avg_bpm,
		ROUND(AVG(m.danceability), 2) AS avg_danceability,
		ROUND(AVG(m.valence), 2) AS avg_valence,
		ROUND(AVG(m.energy), 2) AS avg_energy,
		ROUND(AVG(m.acousticness), 2) AS avg_acousticness,
		ROUND(AVG(m.instrumentalness), 2) AS avg_instrumentalness,
		ROUND(AVG(m.liveness), 2) AS avg_liveness,
		ROUND(AVG(m.speechiness), 2) AS avg_speechiness
FROM most_streamed_songs AS m
RIGHT JOIN (SELECT	song_id,
					track_name,
					SUM(streams) AS total_streams
			FROM most_streamed_songs
			GROUP BY song_id, track_name
			HAVING SUM(streams) > 0
			ORDER BY total_streams DESC
			LIMIT 50) AS s
ON m.song_id = s.song_id;

--8. Which are the most streamed songs from each year?

CREATE VIEW top1_from_each_year AS
SELECT 	m.released_year,
		m.track_name,
		m.song_id,
		m.streams
FROM most_streamed_songs AS m
RIGHT JOIN (SELECT 	released_year,
			MAX(streams) AS max_stream
			FROM most_streamed_songs
			GROUP BY released_year) AS s
ON m.streams = s.max_stream
	AND m.released_year = s.released_year
ORDER BY released_year DESC;

--9. Which artist has more than 1 songs that were most streamed of their year?

SELECT	a.artists_name,
		COUNT(a.artists_name)
FROM most_streamed_songs AS m
LEFT JOIN artists AS a
USING(song_id)
RIGHT JOIN top1_from_each_year
USING(song_id)
GROUP BY a.artists_name
HAVING COUNT(a.artists_name) > 1
ORDER BY COUNT(a.artists_name) DESC;

--10. What is the difference between the attributes of each year's most streamed song and the average attibute avlues of that year?

WITH yearly_avg AS (
SELECT 	released_year,
		ROUND(AVG(bpm), 2) AS avg_bpm,
		ROUND(AVG(danceability), 2) AS avg_danceability,
		ROUND(AVG(valence), 2) AS avg_valence,
		ROUND(AVG(energy), 2) AS avg_energy,
		ROUND(AVG(acousticness), 2) AS avg_acousticness,
		ROUND(AVG(instrumentalness), 2) AS avg_instrumentalness,
		ROUND(AVG(liveness), 2) AS avg_liveness,
		ROUND(AVG(speechiness), 2) AS avg_speechiness
FROM most_streamed_songs
GROUP BY released_year
ORDER BY released_year DESC
)
SELECT	t.released_year,
		t.track_name,
		m.bpm-avg_bpm AS diff_in_bmp,
		m.danceability-avg_danceability AS diff_in_danceability,
		m.valence-avg_valence AS diff_in_valence,
		m.energy-avg_energy AS diff_in_energy,
		m.acousticness-avg_acousticness AS diff_in_acousticness,
		m.instrumentalness-avg_instrumentalness AS diff_in_instrumentalness,
		m.liveness-avg_liveness AS diff_in_liveness,
		m.speechiness-avg_speechiness AS diff_in_speechiness
FROM top1_from_each_year AS t
LEFT JOIN yearly_avg AS y
ON t.released_year = y.released_year
LEFT JOIN most_streamed_songs AS m
ON t.song_id = m.song_id
ORDER BY released_year;

--11. What is the key and model of the songs released during the years of quarantine that remain popular to this day?

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM CROSSTAB($$
WITH replaced_nulls AS(
SELECT CASE WHEN key_musical IS NOT NULL THEN key_musical
		ELSE 'Unknown key' END AS key_without_nulls,
		song_id
FROM most_streamed_songs
)

SELECT CONCAT(r.key_without_nulls, ' ', m.mode_musical) AS key_and_mode, m.released_year, COUNT(*)
FROM most_streamed_songs AS m
LEFT JOIN replaced_nulls AS r
USING(song_id)
WHERE m.released_year IN ('2020', '2021')
GROUP BY key_and_mode, m.released_year
ORDER BY key_and_mode, m.released_year
$$) ct(key_and_mode TEXT,
			"2020" BIGINT,
			"2021" BIGINT)
ORDER BY key_and_mode;
